{... }:



{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/29b54ca4-fced-43f8-a152-fdcc19941f5e";
    fsType = "ext4";
    options = [ "defaults" "noatime" "rw" "uid=1000" "gid=1000" ];
  };

  fileSystems."/mnt/Vault" = {
    device = "/dev/disk/by-uuid/964C6CB04C6C8D35";
    fsType = "ntfs";
    options = [ "uid=1000" "gid=1000" "fmask=0022" "dmask=0000" "windows_names" "big_writes" "rw" ];
  };
}


# {

#   # Enable NTFS
#   boot.supportedFilesystems = [ "ntfs" ];

#   # More Drives
#   fileSystems."/run/media/asyu/Games" = {
#     device = "/dev/sdb2";
#     fsType = "ntfs";
#     options = [ "auto" ];
#   };

#   fileSystems."/run/media/asyu/Vault" = {
#     device = "/dev/sda2";
#     fsType = "ntfs";
#     options = [ "auto" ];
#   };

# }
