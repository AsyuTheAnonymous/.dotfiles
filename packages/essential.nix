{ pkgs, ... }:


{
    # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
  systemd.user.services.opentabletdriver = {
    enable = true;
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };

  # hardware.opentabletdriver.blacklistedKernelModules = [ 
  #   "wacom"
  #   "hid_uclogic"
  # ];

  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    vivaldi
    ghostty
    git
    nemo
    neofetch
    tradingview
    telegram-desktop
    btop
    pavucontrol
    parsec-bin
    protonmail-desktop
    protonvpn-gui
    catppuccin-sddm
    flameshot
    tree
    lolcat
    themechanger
    osu-lazer-bin
    localsend

  ];
}
