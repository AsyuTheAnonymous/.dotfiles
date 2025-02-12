{ pkgs, lib, ... }:


{
    # Sorrrrrrrrrrrrryyyyy
  nixpkgs.config.allowUnfree = true;

  systemd.user.services.opentabletdriver = {
    enable = true;
    description = lib.mkForce "OpenTabletDriver Daemon";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.opentabletdriver}/bin/otd-daemon";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };

  # Enable the OpenTabletDriver
  hardware.opentabletdriver.enable = true;






  # hardware.opentabletdriver = {
  #   enable = true;
  #   daemon.enable = true;
  # };
  # systemd.user.services.opentabletdriver = {
  #   enable = true;
  #   wantedBy = [ "graphical-session.target" ];
  #   after = [ "graphical-session.target" ];
  # };

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
    opentabletdriver
  ];
}
