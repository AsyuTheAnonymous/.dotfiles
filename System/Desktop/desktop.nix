{...}: {
  imports = [
    ./../Common/common.nix
    ./drives/drives.nix
    ./gpu/nvidia.nix
    ./greeter/sddm.nix
  ];
}
