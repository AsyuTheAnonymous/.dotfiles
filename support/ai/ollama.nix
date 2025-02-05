{ config, lib, pkgs, ... }:


{
  environment.systemPackages = with pkgs; [
    ollama
    open-webui
    aider-chat
    open-interpreter
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
    #environmentFile = "/run/media/asyu/Vault/Web-ui/secret/openai.txt";
    environment = {
      #OPENAI_API_BASE_URL = "https://api.mistral.ai/v1";
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
    };
  };
  environment.variables = {
    OPENAI_API_KEY = "$(cat /run/media/asyu/Vault/Web-ui/secret/api.txt)";
    OLLAMA_API_BASE = "http://127.0.0.1:11434";
  };

  # Ollama Web Ui
  # services.nextjs-ollama-llm-ui = {
  #   enable = true;
  #   ollamaUrl = "http://127.0.0.1:11434";
  # };
}