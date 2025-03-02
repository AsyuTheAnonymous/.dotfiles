{... }:



{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/asyu/Games" = {
    device = "/dev/disk/by-uuid/29b54ca4-fced-43f8-a152-fdcc19941f5e";
    fsType = "ext4";
    options = [ "defaults" "user" "rw" ];
    # options = [ "uid=1000" "gid=100" "fmask=0022" "dmask=0000" "windows_names" "big_writes" ];
    # options = [ "auto" ];
  };

  fileSystems."/run/media/asyu/Vault" = {
    device = "/dev/disk/by-uuid/964C6CB04C6C8D35";
    fsType = "ntfs";
    options = [ "uid=1000" "gid=100" "fmask=0022" "dmask=0000" "windows_names" "big_writes" ];
    # options = [ "defaults" "user" "rw" ];
    # options = [ "auto" ];
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
