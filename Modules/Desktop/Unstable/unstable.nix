{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    vesktop
    #atlauncher
    prismlauncher
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
