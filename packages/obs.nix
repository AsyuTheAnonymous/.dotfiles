{ pkgs, lib, ... }:


{
  # Main packages for all my systems
  environment.systemPackages = with pkgs; [
    obs-studio
  ];
}
