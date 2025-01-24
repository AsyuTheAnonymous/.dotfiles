{ config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    ollama
    open-webui
  ];
    # Ollama + Location
  services.ollama = {
    enable = true;
    models = "/run/media/asyu/Vault/Models";
  };
  
  services.open-webui ={
   enable = true;
   port = 8080;
   stateDir = "/run/media/asyu/Vault/Web-ui";
  };


  # Ollama Web Ui
  # services.nextjs-ollama-llm-ui = {
  #   enable = true;
  #   ollamaUrl = "http://127.0.0.1:11434";
  # };
}