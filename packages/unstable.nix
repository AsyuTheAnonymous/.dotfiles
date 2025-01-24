{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable; [
    vesktop
    atlauncher
    prismlauncher
    # osu-lazer-bin
  ];
}
