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
    environmentFile = "/run/media/asyu/Vault/Web-ui/secret/openai.txt";
    environment = {
      WEBUI_AUTH = "False";
      ENABLE_IMAGE_GENERATION = "True";
      IMAGE_GENERATION_MODEL = "dall-e-3";
      ENABLE_RAG_WEB_SEARCH = "True";
      RAG_WEB_SEARCH_ENGINE = "duckduckgo";
      AUDIO_STT_ENGINE = "openai";
      AUDIO_STT_MODEL = "whisper-1";
      AUDIO_TTS_ENGINE = "openai";
      AUDIO_TTS_VOICE = "shimmer";
      ENABLE_EVALUATION_ARENA_MODELS = "False";
      OPENAI_API_KEY = "$(cat ~/.dotfiles/secret/openai.txt)";

    };
  };


  # Ollama Web Ui
  # services.nextjs-ollama-llm-ui = {
  #   enable = true;
  #   ollamaUrl = "http://127.0.0.1:11434";
  # };
}