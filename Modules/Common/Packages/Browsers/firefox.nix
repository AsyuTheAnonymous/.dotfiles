{pkgs-unstable, ...}: {
  environment.systemPackages = with pkgs-unstable; [
    firefox
  ];
}
# { config, lib, pkgs, ... }:
# {
#   options = {
#     myConfig.firefoxOverrides = {
#       enable = lib.mkEnableOption "my custom Firefox overrides";
#       package = lib.mkOption{
#         type = lib.types.package;
#         default = pkgs.firefox;
#         description = "Firefox package to use with these overrides.";
#       };
#       # Make more options
#       defaultSearchEngine = lib.mkOption {
#         type = lib.types.str;
#         default = "DuckDuckGo";
#         description = "Default search engine to set for Firefox.";
#       };
#       extensions = lib.mkOption {
#         type = lib.types.listOf lib.types.package; # Assuming these are Nix packages for extensions
#         default = [];
#         description = "List of Firefox extensions to install with these overrides.";
#       };
#     };
#   };
#   config = lib.mkIf config.myConfig.firefoxOverrides.enable {
#     programs.firefox.package = config.myConfig.firefoxOverrides.package;
#     # To implement defaultSearchEngine, you'd typically use policies:
#     # programs.firefox.policies."SearchEngines" = {
#     #   Default = config.myConfig.firefoxOverrides.defaultSearchEngine;
#     #   # Additional policy settings for search might be needed.
#     # };
#     # To implement extensions, you might use something like:
#     # programs.firefox.extraPackages = config.myConfig.firefoxOverrides.extensions;
#     # Or, if your extensions are not simple packages, you might need a more complex setup,
#     # potentially involving wrapping the Firefox package or using a tool like nixos-firefox-addons.
#   };
# }

