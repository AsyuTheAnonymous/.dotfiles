{
  pkgs,
  ...
}: {
  # Games
  environment.systemPackages = with pkgs; [
    osu-lazer-bin
    runelite
    r2modman
    nexusmods-app
  ];
}
