{ pkgs-unstable, ... }: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    openFirewall = true;
    models = "/home/asyu/models/";
    # loadModels = ["deepseek-r1:8b" "llama3:3b"];
    # environmentVariables = {

    # };
  };
  # services.open-webui = {
  #   enable = true;
  #   port = 8080;
  #   package = open-webui-package;
  #   stateDir = "/run/media/asyu/Vault/open-webui";
  # };
}