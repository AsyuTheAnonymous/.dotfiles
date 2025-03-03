{... }:



{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/asyu/Games" = {
    device = "/dev/disk/by-uuid/7c795867-f039-4de8-8279-30b2e7f4f826";
    fsType = "ext4";
    options = [ "defaults" "noatime" "rw" "nofail" "gid=1000" ];
  #  options = [ "defaults" "noatime" "rw" "uid=1000" "gid=100" ];
  };

  fileSystems."/run/media/asyu/Vault" = {
    device = "/dev/disk/by-uuid/964C6CB04C6C8D35";
    fsType = "ntfs";
    options = [ "uid=1000" "gid=100" "fmask=0022" "dmask=0000" "windows_names" "big_writes" "rw" ];
  };
}

