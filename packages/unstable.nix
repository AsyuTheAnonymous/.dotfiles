{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    webcord-vencord
    atlauncher
    prismlauncher
  ];
}
