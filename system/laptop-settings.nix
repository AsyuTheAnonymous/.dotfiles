{ ... }:

{
  imports = [
    ./audio/pipewire.nix
    # ./greeter/sddm.nix
    ./shell/zsh.nix
    ./network/ssh.nix
    ./network/locale.nix
    ./network/nml.nix
    ./network/bluetooth.nix
    ./network/firewall.nix
    ./bootloader/grub.nix
    #./system/bootloader/sysd.nix
    ./auto.nix
    ./virtualization.nix
  ];
}
