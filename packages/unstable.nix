{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    webcord
    atlauncher
    prismlauncher
  ];
}
