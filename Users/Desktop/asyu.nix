{pkgs, ...}: {
  imports = [
    ./../Github/git.nix
  ];
  users.users.asyu = {
    isNormalUser = true;
    extraGroups = ["wheel" "input" "libvirtd" "video" "uinput" "wireshark" ];
    packages = with pkgs; [
    ];
  };
  environment.sessionVariables = {
    FLAKE = "/home/asyu/.dotfiles/";
  };

  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        {
          command = "${pkgs.procps}/bin/pkill -f openvpn*";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.openvpn}/bin/openvpn *";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };
}
