{
  pkgs,
  ...
}: {
  # Games
  environment.systemPackages = with pkgs; [
    osu-lazer-bin
    r2modman
    nexusmods-app
  ];
}
