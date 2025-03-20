{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    open-webui
  ];

  services.open-webui = {
    enable = true;
    port = 8080;
    stateDir = "$WEBUI_STATE_DIR";
    #environmentFile = "/run/media/asyu/Vault/Web-ui/secret/openai.txt";
    environment = {
      WEBUI_AUTH = "$WEBUI_AUTH";
      ENABLE_IMAGE_GENERATION = "$ENABLE_IMAGE_GENERATION";
      IMAGE_GENERATION_MODEL = "$IMAGE_GENERATION_MODEL";
      ENABLE_RAG_WEB_SEARCH = "$ENABLE_RAG_WEB_SEARCH";
      RAG_WEB_SEARCH_ENGINE = "$RAG_WEB_SEARCH_ENGINE";
      AUDIO_STT_ENGINE = "$AUDIO_STT_ENGINE";
      AUDIO_STT_MODEL = "$AUDIO_STT_MODEL";
      AUDIO_TTS_ENGINE = "$AUDIO_TTS_ENGINE";
      AUDIO_TTS_VOICE = "$AUDIO_TTS_VOICE";
      ENABLE_EVALUATION_ARENA_MODELS = "$ENABLE_EVALUATION_ARENA_MODELS";
    };
  };
}
