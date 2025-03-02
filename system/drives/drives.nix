{... }:



{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/asyu/Games" = {
    device = "/dev/disk/by-uuid/4E385FD5385FBB23";
    fsType = "ntfs";
    options = [ "uid=1000" "gid=100" "fmask=0022" "dmask=0000" "windows_names" "big_writes" ];
    # options = [ "auto" ];
  };

  fileSystems."/run/media/asyu/Vault" = {
    device = "/dev/disk/by-uuid/964C6CB04C6C8D35";
    fsType = "ntfs";
    options = [ "uid=1000" "gid=100" "fmask=0022" "dmask=0000" "windows_names" "big_writes" ];
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
