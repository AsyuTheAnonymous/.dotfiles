{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    vesktop
    warp-terminal
    #atlauncher
    #figma-linux
    wine
    winetricks
    #zed-editor
    #Nix Language server
    nixd
    nil
    r2modman
  ];
}
