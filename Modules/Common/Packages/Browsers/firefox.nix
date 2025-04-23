{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    firefox
  ];
}
