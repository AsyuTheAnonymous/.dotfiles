{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    discord
    atlauncher
    prismlauncher
  ];
}
