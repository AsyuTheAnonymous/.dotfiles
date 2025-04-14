{
  config,
  lib,
  pkgs-unstable,
  ...
}: {
  # environment.systemPackages = with pkgs-unstable; [
  #   open-webui
  # ];

  services.open-webui = {
    enable = true;
    port = 8080;
    package = pkgs-unstable.open-webui;
    stateDir = "/run/media/asyu/Vault/Web-ui";
    #environmentFile = "/run/media/asyu/Vault/Web-ui/secret/openai.txt";
    environment = {
      # HOST = "0.0.0.0";
      # WEBUI_AUTH = "False";
      #   ENABLE_IMAGE_GENERATION = "$ENABLE_IMAGE_GENERATION";
      #   IMAGE_GENERATION_MODEL = "$IMAGE_GENERATION_MODEL";
      #   ENABLE_RAG_WEB_SEARCH = "$ENABLE_RAG_WEB_SEARCH";
      #   RAG_WEB_SEARCH_ENGINE = "$RAG_WEB_SEARCH_ENGINE";
      #   AUDIO_STT_ENGINE = "$AUDIO_STT_ENGINE";
      #   AUDIO_STT_MODEL = "$AUDIO_STT_MODEL";
      #   AUDIO_TTS_ENGINE = "$AUDIO_TTS_ENGINE";
      #   AUDIO_TTS_VOICE = "$AUDIO_TTS_VOICE";
      #   ENABLE_EVALUATION_ARENA_MODELS = "$ENABLE_EVALUATION_ARENA_MODELS";
    };
  };
}
