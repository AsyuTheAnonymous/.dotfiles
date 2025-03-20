{
  config,
  lib,
  ...
}: {
  systemd.user.services.opentabletdriver = {
    enable = true;
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];
  };

  # Enable the OpenTabletDriver
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}
