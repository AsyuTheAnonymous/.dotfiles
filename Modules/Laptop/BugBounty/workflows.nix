# Automated Workflows for Bug Bounty Hunting
{ config, pkgs, pkgs-unstable, lib, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    # Workflow automation tools
    tmux
    tmuxinator
    entr         # File watcher to trigger commands
    jq           # JSON processor
    yq           # YAML processor
    parallel     # Run tasks in parallel
    
    # Note-taking and documentation
    obsidian     # Note-taking app with markdown support
    cherrytree   # Hierarchical note taking
    
    # Screenshot and evidence gathering
    flameshot
    peek         # GIF recorder
    
    # Workflow management
    taskwarrior  # Task management
    timewarrior  # Time tracking
    
    # Custom reporting
    pandoc       # Document converter
    
    # Create a complete bug bounty workflow manager
    (pkgs.writeShellScriptBin "bb-workflow" ''
      #!/usr/bin/env bash
      # Bug Bounty Workflow Manager
      
      # Define directories
      BBDIR="$HOME/BugBounty"
      TOOLSDIR="$BBDIR/Tools"
      TARGETSDIR="$BBDIR/Targets"
      REPORTSDIR="$BBDIR/Reports"
      TEMPLATESDIR="$BBDIR/Templates"
      SCRIPTSDIR="$BBDIR/Scripts"
      
      # Create the directory structure if it doesn't exist
      mkdir -p "$TOOLSDIR" "$TARGETSDIR" "$REPORTSDIR" "$TEMPLATESDIR" "$SCRIPTSDIR"
      
      # Function to create a new target
      create_target() {
        read -p "Enter target domain: " DOMAIN
        TARGET_DIR="$TARGETSDIR/$DOMAIN"
        
        if [ -d "$TARGET_DIR" ]; then
          echo "[!] Target directory already exists!"
          read -p "Overwrite? (y/n): " OVERWRITE
          if [[ ! $OVERWRITE =~ ^[Yy]$ ]]; then
            return
          fi
        fi
        
        # Create target directory structure
        mkdir -p "$TARGET_DIR"/{recon,web,endpoints,vulnerabilities,notes,evidence}
        
        # Create initial notes file
        cat > "$TARGET_DIR/notes/initial.md" << EOL
# Bug Bounty - $DOMAIN

## Target Information
- Domain: $DOMAIN
- Date Started: $(date +"%Y-%m-%d")
- Scope: TBD

## Methodology Checklist
- [ ] Subdomain Enumeration
- [ ] Port Scanning
- [ ] Service Enumeration
- [ ] Screenshot Analysis
- [ ] Content Discovery
- [ ] Parameter Analysis
- [ ] Vulnerability Testing

## Quick Notes

EOL
        
        echo "[+] Target directory created at: $TARGET_DIR"
        echo "[+] Initial notes file created at: $TARGET_DIR/notes/initial.md"
        
        # Ask if user wants to start recon now
        read -p "Start reconnaissance now? (y/n): " START_RECON
        if [[ $START_RECON =~ ^[Yy]$ ]]; then
          laptop-recon "$DOMAIN"
        fi
      }
      
      # Function to create a new report
      create_report() {
        # List available targets
        echo "Available targets:"
        ls -1 "$TARGETSDIR"
        
        read -p "Enter target domain: " DOMAIN
        read -p "Enter vulnerability name: " VULN_NAME
        read -p "Enter severity (Critical/High/Medium/Low/Info): " SEVERITY
        
        # Sanitize input for filename
        SAFE_VULN_NAME=$(echo "$VULN_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
        REPORT_FILE="$REPORTSDIR/${DOMAIN}_${SAFE_VULN_NAME}_$(date +"%Y%m%d").md"
        
        # Create report from template
        cat > "$REPORT_FILE" << EOL
# Bug Bounty Report: $VULN_NAME

## Target Information
- Domain: $DOMAIN
- Date: $(date +"%Y-%m-%d")
- Severity: $SEVERITY

## Vulnerability Details

### Description

### Steps to Reproduce
1. 

### Impact

### Proof of Concept

### Remediation

## Evidence
[Include screenshots, code snippets, etc.]

EOL
        
        echo "[+] Report created at: $REPORT_FILE"
        
        # Open in default editor
        if [ -n "$EDITOR" ]; then
          $EDITOR "$REPORT_FILE"
        else
          echo "[+] Open the report in your text editor to complete it"
        fi
      }
      
      # Function to start a preset tmux session for bug bounty
      start_bb_session() {
        read -p "Enter target domain (leave empty for general session): " DOMAIN
        
        SESSION_NAME="bugbounty"
        if [ -n "$DOMAIN" ]; then
          SESSION_NAME="bb-$DOMAIN"
        fi
        
        # Check if the session already exists
        if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
          echo "[+] Session '$SESSION_NAME' already exists, attaching..."
          tmux attach-session -t "$SESSION_NAME"
          return
        fi
        
        # Create a new session
        tmux new-session -d -s "$SESSION_NAME" -n "main"
        
        # Set up windows and panes
        tmux split-window -h -t "$SESSION_NAME:main"
        tmux split-window -v -t "$SESSION_NAME:main.1"
        
        # Create additional windows
        tmux new-window -t "$SESSION_NAME" -n "recon"
        tmux new-window -t "$SESSION_NAME" -n "web"
        tmux new-window -t "$SESSION_NAME" -n "exploit"
        tmux new-window -t "$SESSION_NAME" -n "notes"
        
        # Configure windows with specific commands
        if [ -n "$DOMAIN" ]; then
          # Initialize domain-specific tools
          TARGET_DIR="$TARGETSDIR/$DOMAIN"
          mkdir -p "$TARGET_DIR"
          
          # Set up notes window with vim
          tmux send-keys -t "$SESSION_NAME:notes" "cd $TARGET_DIR/notes && vim -c 'NERDTree' ." C-m
          
          # Set up recon window
          tmux send-keys -t "$SESSION_NAME:recon" "cd $TARGET_DIR/recon" C-m
          
          # Set up web window with burp proxy setting
          tmux send-keys -t "$SESSION_NAME:web" "cd $TARGET_DIR/web && export http_proxy=http://127.0.0.1:8080 && export https_proxy=http://127.0.0.1:8080" C-m
          
          # Main window setup
          tmux send-keys -t "$SESSION_NAME:main.0" "cd $TARGET_DIR && ls -la" C-m
          tmux send-keys -t "$SESSION_NAME:main.1" "cd $TARGET_DIR && htop" C-m
          tmux send-keys -t "$SESSION_NAME:main.2" "cd $TARGET_DIR && echo 'Target: $DOMAIN' && date" C-m
        else
          # Generic setup for general session
          tmux send-keys -t "$SESSION_NAME:notes" "cd $BBDIR/notes && vim -c 'NERDTree' ." C-m
          tmux send-keys -t "$SESSION_NAME:main.0" "cd $BBDIR && ls -la" C-m
          tmux send-keys -t "$SESSION_NAME:main.1" "htop" C-m
          tmux send-keys -t "$SESSION_NAME:main.2" "echo 'Bug Bounty Session Started' && date" C-m
        fi
        
        # Return to the main window
        tmux select-window -t "$SESSION_NAME:main"
        
        # Attach to the session
        tmux attach-session -t "$SESSION_NAME"
      }
      
      # Function to extract findings from a target directory and create a summary
      summarize_target() {
        # List available targets
        echo "Available targets:"
        ls -1 "$TARGETSDIR"
        
        read -p "Enter target domain: " DOMAIN
        TARGET_DIR="$TARGETSDIR/$DOMAIN"
        
        if [ ! -d "$TARGET_DIR" ]; then
          echo "[!] Target directory doesn't exist!"
          return
        fi
        
        SUMMARY_FILE="$TARGET_DIR/summary_$(date +"%Y%m%d").md"
        
        echo "# Target Summary: $DOMAIN" > "$SUMMARY_FILE"
        echo "Generated on $(date)" >> "$SUMMARY_FILE"
        echo "" >> "$SUMMARY_FILE"
        
        # Summarize recon
        echo "## Reconnaissance" >> "$SUMMARY_FILE"
        if [ -f "$TARGET_DIR/recon/subdomains.txt" ]; then
          SUBDOMAIN_COUNT=$(wc -l < "$TARGET_DIR/recon/subdomains.txt")
          echo "- Subdomains discovered: $SUBDOMAIN_COUNT" >> "$SUMMARY_FILE"
        fi
        
        if [ -f "$TARGET_DIR/recon/live_hosts.txt" ]; then
          LIVE_HOST_COUNT=$(wc -l < "$TARGET_DIR/recon/live_hosts.txt")
          echo "- Live hosts: $LIVE_HOST_COUNT" >> "$SUMMARY_FILE"
        fi
        
        if [ -f "$TARGET_DIR/recon/ports.txt" ]; then
          echo "- Interesting open ports:" >> "$SUMMARY_FILE"
          grep "open" "$TARGET_DIR/recon/ports.txt" | head -5 >> "$SUMMARY_FILE"
          if [ $(grep -c "open" "$TARGET_DIR/recon/ports.txt") -gt 5 ]; then
            echo "  (See recon/ports.txt for full list)" >> "$SUMMARY_FILE"
          fi
        fi
        
        # Summarize web findings
        echo "" >> "$SUMMARY_FILE"
        echo "## Web Findings" >> "$SUMMARY_FILE"
        if [ -d "$TARGET_DIR/web" ]; then
          find "$TARGET_DIR/web" -type f -name "*.txt" | while read file; do
            filename=$(basename "$file")
            echo "- $filename findings:" >> "$SUMMARY_FILE"
            head -3 "$file" >> "$SUMMARY_FILE"
            echo "  ..." >> "$SUMMARY_FILE"
          done
        else
          echo "No web findings recorded yet." >> "$SUMMARY_FILE"
        fi
        
        # Summarize vulnerabilities
        echo "" >> "$SUMMARY_FILE"
        echo "## Identified Vulnerabilities" >> "$SUMMARY_FILE"
        VULN_DIR="$TARGET_DIR/vulnerabilities"
        if [ -d "$VULN_DIR" ] && [ "$(ls -A "$VULN_DIR")" ]; then
          find "$VULN_DIR" -type f | while read vuln_file; do
            filename=$(basename "$vuln_file")
            echo "- $filename" >> "$SUMMARY_FILE"
          done
        else
          echo "No vulnerabilities documented yet." >> "$SUMMARY_FILE"
        fi
        
        # Include notes
        echo "" >> "$SUMMARY_FILE"
        echo "## Notes" >> "$SUMMARY_FILE"
        NOTES_DIR="$TARGET_DIR/notes"
        if [ -d "$NOTES_DIR" ] && [ "$(ls -A "$NOTES_DIR")" ]; then
          find "$NOTES_DIR" -type f -name "*.md" | while read note_file; do
            echo "### $(basename "$note_file")" >> "$SUMMARY_FILE"
            head -10 "$note_file" >> "$SUMMARY_FILE"
            echo "..." >> "$SUMMARY_FILE"
            echo "" >> "$SUMMARY_FILE"
          done
        else
          echo "No notes available." >> "$SUMMARY_FILE"
        fi
        
        echo "[+] Summary created at: $SUMMARY_FILE"
        
        # Convert to PDF if pandoc is available
        if command -v pandoc &> /dev/null; then
          PDF_FILE="''${SUMMARY_FILE%.md}.pdf"
          echo "[+] Converting to PDF..."
          pandoc "$SUMMARY_FILE" -o "$PDF_FILE"
          echo "[+] PDF created at: $PDF_FILE"
        fi
      }
      
      # Main menu
      show_menu() {
        echo "============================================"
        echo "         Bug Bounty Workflow Manager        "
        echo "============================================"
        echo "1. Create new target"
        echo "2. Start reconnaissance (basic)"
        echo "3. Start reconnaissance (thorough - power)"
        echo "4. Create vulnerability report"
        echo "5. Start bug bounty tmux session"
        echo "6. Create target summary"
        echo "0. Exit"
        echo "============================================"
        read -p "Select an option: " OPTION
        
        case $OPTION in
          1) create_target ;;
          2)
            echo "Available targets:"
            ls -1 "$TARGETSDIR"
            read -p "Enter target domain: " DOMAIN
            laptop-recon "$DOMAIN"
            ;;
          3)
            echo "Available targets:"
            ls -1 "$TARGETSDIR"
            read -p "Enter target domain: " DOMAIN
            power-recon "$DOMAIN"
            ;;
          4) create_report ;;
          5) start_bb_session ;;
          6) summarize_target ;;
          0) exit 0 ;;
          *) echo "Invalid option" ;;
        esac
        
        # Return to menu after function completes
        show_menu
      }
      
      # Start the workflow manager
      show_menu
    '')
    
    # Create a multi-target launcher for lazy loading tools
    (pkgs.writeShellScriptBin "bb-recon-multi" ''
      #!/usr/bin/env bash
      # Multi-target reconnaissance manager
      
      if [ $# -lt 1 ]; then
        echo "Usage: bb-recon-multi <targets-file>"
        echo "The targets file should contain one domain per line"
        exit 1
      fi
      
      TARGETS_FILE=$1
      BBDIR="$HOME/BugBounty"
      LOGFILE="$BBDIR/multi_recon_$(date +"%Y%m%d_%H%M%S").log"
      
      if [ ! -f "$TARGETS_FILE" ]; then
        echo "[!] Targets file not found: $TARGETS_FILE"
        exit 1
      fi
      
      echo "[+] Starting multi-target reconnaissance..."
      echo "[+] Log file: $LOGFILE"
      
      # Check battery status
      BATTERY_PCT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo "100")
      ON_AC=$(cat /sys/class/power_supply/*/online 2>/dev/null | grep 1)
      
      if [ "$BATTERY_PCT" -lt "50" ] && [ -z "$ON_AC" ]; then
        echo "[!] Warning: Battery below 50% and not connected to power."
        echo "[!] This script may drain your battery quickly."
        read -p "Continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
          exit 1
        fi
        
        # Use laptop-recon for battery savings
        RECON_SCRIPT="laptop-recon"
        PARALLEL_JOBS=2
      else
        # Use more intensive recon when plugged in
        RECON_SCRIPT="power-recon"
        PARALLEL_JOBS=4
      fi
      
      # Process targets in parallel
      echo "[+] Using $RECON_SCRIPT with $PARALLEL_JOBS parallel jobs"
      cat "$TARGETS_FILE" | parallel -j "$PARALLEL_JOBS" "$RECON_SCRIPT" {} ">&2" "2>>$LOGFILE"
      
      echo "[+] Multi-target reconnaissance completed!"
      echo "[+] Check the log file for details: $LOGFILE"
    '')
    
    # Simple time tracker for bug bounty activities
    (pkgs.writeShellScriptBin "bb-track" ''
      #!/usr/bin/env bash
      # Simple time tracker for bug bounty activities
      
      TRACKING_DIR="$HOME/BugBounty/tracking"
      mkdir -p "$TRACKING_DIR"
      
      CURRENT_SESSION="$TRACKING_DIR/current_session"
      
      start_tracking() {
        if [ -f "$CURRENT_SESSION" ]; then
          echo "[!] Tracking already in progress"
          cat "$CURRENT_SESSION"
          return
        fi
        
        read -p "Enter target domain: " DOMAIN
        read -p "Enter activity (recon, exploit, web, report): " ACTIVITY
        
        echo "target=$DOMAIN" > "$CURRENT_SESSION"
        echo "activity=$ACTIVITY" >> "$CURRENT_SESSION"
        echo "start=$(date +%s)" >> "$CURRENT_SESSION"
        echo "start_time=$(date)" >> "$CURRENT_SESSION"
        
        echo "[+] Started tracking: $ACTIVITY on $DOMAIN at $(date)"
      }
      
      stop_tracking() {
        if [ ! -f "$CURRENT_SESSION" ]; then
          echo "[!] No tracking session in progress"
          return
        fi
        
        # Load session info
        source "$CURRENT_SESSION"
        
        # Calculate duration
        END_TIME=$(date +%s)
        DURATION=$((END_TIME - start))
        HOURS=$((DURATION / 3600))
        MINUTES=$(( (DURATION % 3600) / 60 ))
        SECONDS=$((DURATION % 60))
        
        # Format duration
        DURATION_FORMAT="$(printf "%02d:%02d:%02d" $HOURS $MINUTES $SECONDS)"
        
        # Save to log
        LOG_FILE="$TRACKING_DIR/time_log.csv"
        if [ ! -f "$LOG_FILE" ]; then
          echo "date,target,activity,duration_seconds,duration_formatted,notes" > "$LOG_FILE"
        fi
        
        read -p "Add notes: " NOTES
        
        echo "$(date +%Y-%m-%d),$target,$activity,$DURATION,\"$DURATION_FORMAT\",\"$NOTES\"" >> "$LOG_FILE"
        
        echo "[+] Stopped tracking: $activity on $target"
        echo "[+] Duration: $DURATION_FORMAT"
        
        # Remove current session
        rm "$CURRENT_SESSION"
      }
      
      show_status() {
        if [ ! -f "$CURRENT_SESSION" ]; then
          echo "[!] No tracking session in progress"
          return
        fi
        
        # Load session info
        source "$CURRENT_SESSION"
        
        # Calculate current duration
        CURRENT_TIME=$(date +%s)
        DURATION=$((CURRENT_TIME - start))
        HOURS=$((DURATION / 3600))
        MINUTES=$(( (DURATION % 3600) / 60 ))
        SECONDS=$((DURATION % 60))
        
        # Format duration
        DURATION_FORMAT="$(printf "%02d:%02d:%02d" $HOURS $MINUTES $SECONDS)"
        
        echo "[+] Current session:"
        echo "    Target: $target"
        echo "    Activity: $activity"
        echo "    Started: $start_time"
        echo "    Duration: $DURATION_FORMAT"
      }
      
      show_summary() {
        LOG_FILE="$TRACKING_DIR/time_log.csv"
        
        if [ ! -f "$LOG_FILE" ]; then
          echo "[!] No tracking data available"
          return
        fi
        
        # Skip header
        TOTAL_SECONDS=0
        while IFS=, read -r date target activity duration_seconds duration_formatted notes; do
          if [ "$date" != "date" ]; then  # Skip header
            TOTAL_SECONDS=$((TOTAL_SECONDS + duration_seconds))
          fi
        done < "$LOG_FILE"
        
        # Calculate total time
        TOTAL_HOURS=$((TOTAL_SECONDS / 3600))
        TOTAL_MINUTES=$(( (TOTAL_SECONDS % 3600) / 60 ))
        TOTAL_SECONDS=$((TOTAL_SECONDS % 60))
        
        # Format total time
        TOTAL_FORMAT="$(printf "%02d:%02d:%02d" $TOTAL_HOURS $TOTAL_MINUTES $TOTAL_SECONDS)"
        
        echo "[+] Time tracking summary:"
        echo "    Total time: $TOTAL_FORMAT"
        
        # Time by target
        echo "[+] Time by target:"
        awk -F, '{if(NR>1) print $2}' "$LOG_FILE" | sort | uniq -c | sort -nr | 
          while read count target; do
            echo "    $target: $count entries"
          done
        
        # Time by activity
        echo "[+] Time by activity:"
        awk -F, '{if(NR>1) print $3}' "$LOG_FILE" | sort | uniq -c | sort -nr |
          while read count activity; do
            echo "    $activity: $count entries"
          done
        
        # Recent entries
        echo "[+] Recent entries:"
        tail -5 "$LOG_FILE" | awk -F, '{if(NR>1) printf "    %s: %s on %s (%s)\n", $1, $3, $2, $5}' | tac
      }
      
      # Main options
      case "$1" in
        start)
          start_tracking
          ;;
        stop)
          stop_tracking
          ;;
        status)
          show_status
          ;;
        summary)
          show_summary
          ;;
        *)
          echo "Usage: bb-track <command>"
          echo "Commands:"
          echo "  start    - Start tracking time"
          echo "  stop     - Stop tracking time"
          echo "  status   - Show current tracking status"
          echo "  summary  - Show summary of tracked time"
          ;;
      esac
    '')
  ];
  
  # Configure tmux for bug bounty workflows
  environment.etc."bugbounty/tmux.conf".text = ''
    # Bug Bounty optimized tmux configuration
    
    # Increase scrollback buffer size
    set-option -g history-limit 10000
    
    # Enable mouse support
    set-option -g mouse on
    
    # Use a different prefix to avoid conflicts
    unbind C-b
    set-option -g prefix C-a
    bind-key C-a send-prefix
    
    # Reload configuration
    bind r source-file /etc/bugbounty/tmux.conf \; display-message "Config reloaded!"
    
    # Split panes using | and -
    bind | split-window -h
    bind - split-window -v
    unbind '"'
    unbind %
    
    # Quick window switching
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D
    
    # Bug bounty specific keybindings
    bind-key b new-window -n "burp" "burpsuite"
    bind-key z new-window -n "zap" "zaproxy"
    bind-key n new-window -n "notes" "cd ~/BugBounty/notes && vim"
    
    # For quick commands across all panes
    bind-key e setw synchronize-panes
    
    # Status bar
    set -g status-bg black
    set -g status-fg white
    set -g status-left '#[fg=green]#(whoami)@#H #[fg=white]: #[fg=yellow]#S'
    set -g status-left-length 40
    set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'
    
    # Show activity in other windows
    setw -g monitor-activity on
    set -g visual-activity on
  '';
  
  # Create a systemd service to sync notes in the background
  systemd.user.services = {
    bugbounty-sync = {
      description = "Sync bug bounty notes";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "sync-bugbounty-notes" ''
          #!/usr/bin/env bash
          
          BBDIR="$HOME/BugBounty"
          SYNC_LOG="$BBDIR/sync.log"
          
          # Log start time
          echo "$(date): Starting sync" >> "$SYNC_LOG"
          
          # Check if git is initialized
          if [ ! -d "$BBDIR/.git" ]; then
            echo "$(date): Initializing git repository" >> "$SYNC_LOG"
            cd "$BBDIR" && git init
            echo "notes/" > "$BBDIR/.gitignore"
            echo "reports/" >> "$BBDIR/.gitignore"
            cd "$BBDIR" && git add .gitignore
            cd "$BBDIR" && git commit -m "Initial commit"
          fi
          
          # Sync notes (only if git remote is configured)
          if cd "$BBDIR" && git remote -v | grep -q origin; then
            echo "$(date): Syncing with remote repository" >> "$SYNC_LOG"
            cd "$BBDIR" && git pull origin main
            cd "$BBDIR" && git add notes/ reports/
            cd "$BBDIR" && git commit -m "Auto-sync: $(date)" || true
            cd "$BBDIR" && git push origin main
          else
            echo "$(date): No remote repository configured. Skipping sync." >> "$SYNC_LOG"
          fi
          
          # Backup to local folder
          BACKUP_DIR="$HOME/Backups/BugBounty"
          mkdir -p "$BACKUP_DIR"
          BACKUP_FILE="$BACKUP_DIR/bugbounty_$(date +"%Y%m%d").tar.gz"
          
          echo "$(date): Creating local backup at $BACKUP_FILE" >> "$SYNC_LOG"
          tar -czf "$BACKUP_FILE" -C "$HOME" "BugBounty/notes" "BugBounty/reports"
          
          # Keep only the last 5 backups
          ls -t "$BACKUP_DIR"/bugbounty_*.tar.gz | tail -n +6 | xargs -r rm
          
          echo "$(date): Sync completed" >> "$SYNC_LOG"
        ''}/bin/sync-bugbounty-notes";
        Restart = "on-failure";
      };
      wantedBy = [];  # Not auto-started, manual control
    };
  };
  
  # Create a timer to periodically sync notes
  systemd.user.timers = {
    bugbounty-sync = {
      description = "Timer for bug bounty notes sync";
      timerConfig = {
        OnBootSec = "10m";
        OnUnitActiveSec = "30m";  # Sync every 30 minutes when active
        Unit = "bugbounty-sync.service";
      };
      wantedBy = [ "timers.target" ];
    };
  };
  
  # Create helper scripts for resource management
  environment.systemPackages = let
    power-mode-toggle = pkgs.writeShellScriptBin "toggle-power-mode" ''
      #!/usr/bin/env bash
      # Toggle between power save and performance modes
      
      CURRENT_GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
      
      if [ "$CURRENT_GOVERNOR" = "powersave" ]; then
        echo "[+] Switching to performance mode..."
        sudo cpupower frequency-set -g performance
        
        # Start resource-intensive services
        systemctl --user start burpsuite-headless.service
        
        echo "[+] Performance mode activated"
        echo "[!] Warning: This may drain your battery quickly"
      else
        echo "[+] Switching to power saving mode..."
        sudo cpupower frequency-set -g powersave
        
        # Stop resource-intensive services
        systemctl --user stop burpsuite-headless.service
        
        echo "[+] Power saving mode activated"
      fi
    '';
    
    battery-monitor = pkgs.writeShellScriptBin "battery-monitor" ''
      #!/usr/bin/env bash
      # Monitor battery and automatically switch to power saving mode
      
      THRESHOLD=20  # Battery percentage threshold
      
      while true; do
        # Get battery percentage
        BATTERY_PCT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo "100")
        ON_AC=$(cat /sys/class/power_supply/*/online 2>/dev/null | grep 1)
        
        if [ -z "$ON_AC" ] && [ "$BATTERY_PCT" -lt "$THRESHOLD" ]; then
          # Check current governor
          CURRENT_GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
          
          if [ "$CURRENT_GOVERNOR" != "powersave" ]; then
            echo "[!] Battery below $THRESHOLD% threshold ($BATTERY_PCT%). Switching to power saving mode..."
            notify-send "Battery Low" "Switching to power saving mode ($BATTERY_PCT%)" --urgency=critical
            
            # Switch to power saving mode
            sudo cpupower frequency-set -g powersave
            
            # Stop resource-intensive services
            systemctl --user stop burpsuite-headless.service
            
            echo "[+] Power saving mode activated"
          fi
        fi
        
        # Check if we've connected to AC
        if [ -n "$ON_AC" ]; then
          echo "[+] Connected to AC power. You can switch to performance mode if needed."
          notify-send "AC Power Connected" "You can switch to performance mode if needed." --urgency=low
        fi
        
        # Sleep for 5 minutes
        sleep 300
      done
    '';
    
    # Create battery-friendly launcher for programs
    eco-launcher = pkgs.writeShellScriptBin "eco-launch" ''
      #!/usr/bin/env bash
      # Battery-friendly launcher for resource-intensive programs
      
      if [ $# -lt 1 ]; then
        echo "Usage: eco-launch <program> [args...]"
        exit 1
      fi
      
      PROGRAM="$1"
      shift
      
      # Get battery status
      BATTERY_PCT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo "100")
      ON_AC=$(cat /sys/class/power_supply/*/online 2>/dev/null | grep 1)
      
      if [ -z "$ON_AC" ] && [ "$BATTERY_PCT" -lt "50" ]; then
        echo "[!] Warning: Battery below 50% ($BATTERY_PCT%) and not on AC power."
        echo "[!] Running resource-intensive programs may drain your battery quickly."
        read -p "Continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
          exit 1
        fi
      fi
      
      # Set resource limits
      if [ -z "$ON_AC" ]; then
        # On battery, set CPU affinity to use fewer cores
        CPU_COUNT=$(nproc)
        if [ "$CPU_COUNT" -gt 2 ]; then
          CORES=$((CPU_COUNT / 2))
          echo "[+] Running $PROGRAM with CPU affinity limited to $CORES cores to save battery"
          exec taskset -c 0-$((CORES-1)) nice -n 10 "$PROGRAM" "$@"
        else
          echo "[+] Running $PROGRAM with reduced priority to save battery"
          exec nice -n 10 "$PROGRAM" "$@"
        fi
      else
        # On AC, run normally
        echo "[+] Running $PROGRAM normally"
        exec "$PROGRAM" "$@"
      fi
    '';
    
  in [
    power-mode-toggle
    battery-monitor
    eco-launcher
  ];
}