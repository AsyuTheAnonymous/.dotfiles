{ config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    ollama
  ];
    # Ollama + Location
  services.ollama = {
    enable = true;
    models = "/run/media/asyu/Vault/Models";
  };
  # Ollama Web Ui
  services.nextjs-ollama-llm-ui = {
    enable = true;
    ollamaUrl = "http://127.0.0.1:11434";
  };
}