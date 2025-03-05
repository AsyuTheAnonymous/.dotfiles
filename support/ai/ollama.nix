{ config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    ollama-cuda
  ];
    # Ollama + Location
  services.ollama = {
    enable = true;
    models = "/run/media/asyu/Vault/Models";
  };
  
  environment.variables = {
    OPENAI_API_KEY = "$(cat /run/media/asyu/Vault/Web-ui/secret/openai.txt)";
    GROQ_API_KEY = "$(cat /run/media/asyu/Vault/Web-ui/secret/groq.txt)";
    OLLAMA_API_BASE = "http://127.0.0.1:11434";
    # AIDER_TIMEOUT = 10;
  };

  # Ollama Web Ui
  # services.nextjs-ollama-llm-ui = {
  #   enable = true;
  #   ollamaUrl = "http://127.0.0.1:11434";
  # };
}