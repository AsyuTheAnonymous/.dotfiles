{pkgs, ...}: {
  # Games
  environment.systemPackages = with pkgs; [
    osu-lazer-bin
    nexusmods-app
  ];
}
