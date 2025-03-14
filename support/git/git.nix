{ config, lib, pkgs, ... }: {
    programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      user = {
        name = "AsyuTheAnonymous";
        email = "asyutheanonymous@gmail.com";
      };
      safe.directory = "/run/media/asyu/Vault";
    };
  };

}