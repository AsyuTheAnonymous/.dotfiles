{...}: {
  imports = [
    ./audio/pipewire.nix
    ./bootloader/grub.nix
    ./fonts/nerd.nix
    ./greeter/sddm.nix
    ./network/config.nix
    ./shell/zsh.nix
  ];
}
