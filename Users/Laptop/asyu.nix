{pkgs, ...}: {
  imports = [
    ./../Github/git.nix
  ];
  users.users.asyu = {
    isNormalUser = true;
    extraGroups = ["wheel" "input" "libvirtd" "wireshark"];
    packages = with pkgs; [
    ];
  };
  environment.sessionVariables = {
    FLAKE = "/home/asyu/.dotfiles/";
  };
}
