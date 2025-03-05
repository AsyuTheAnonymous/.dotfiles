  {config, lib, pkgs, ... }:
  
{
  environment.systemPackages = with pkgs; [
    open-webui
  ];
  
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
}