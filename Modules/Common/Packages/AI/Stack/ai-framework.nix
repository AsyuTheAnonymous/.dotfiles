{ pkgs-unstable, ... }: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    openFirewall = true;
    # models = "/home/asyu/models/";
    host = "192.168.12.200";
    port = 11434;
    # loadModels = ["deepseek-r1:8b" "llama3:3b"];
    # environmentVariables = {
    #   OLLAMA_HOST = "192.168.12.200";
    # };
  };
    # Custom service to auto-start ollama if it's not running
  systemd.services."ollama-autostart" = {
    description = "Auto-start ollama if it's not running";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs-unstable.bash}/bin/bash -c ''
        if ! pgrep -x ollama >/dev/null; then
          echo 'Ollama not running, starting...'
          nohup ${pkgs-unstable.ollama}/bin/ollama serve >/var/log/ollama-autostart.log 2>&1 &
        else
          echo 'Ollama already running.'
        fi
      ''";
      Restart = "on-failure";
    };
  };
  # services.open-webui = {
  #   enable = true;
  #   port = 8080;
  #   package = open-webui-package;
  #   stateDir = "/run/media/asyu/Vault/open-webui";
  # };
}