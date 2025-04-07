{ config, lib, pkgs, ... }: {
    service.emacs = {
        enable = true;
        package = pkgs.emacs;
    }
}