{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    vesktop
    atlauncher
    prismlauncher
    figma-linux
  ];
}
