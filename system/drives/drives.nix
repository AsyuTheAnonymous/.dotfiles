{... }:

{

  # Enable NTFS
  boot.supportedFilesystems = [ "ntfs" ];

  # More Drives
  fileSystems."/run/media/asyu/Games" = {
    device = "/dev/sdb2";
    fsType = "ntfs";
    options = [ "auto" ];
  };

  fileSystems."/run/media/asyu/Vault" = {
    device = "/dev/sda2";
    fsType = "ntfs";
    options = [ "auto" ];
  };

}
