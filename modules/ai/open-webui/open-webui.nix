{ config, lib, pkgs, pkgs-unstable, ... }:

let
  # Use unstable packages provided by flake inputs
  # Build the custom package using unstable dependencies
  open-webui-package = pkgs-unstable.callPackage ./package.nix {
    inherit (pkgs-unstable) python312 buildNpmPackage fetchFromGitHub nixosTests fetchurl;
  };
in {
  services.open-webui = {
    enable = true;
    port = 8080;
    package = open-webui-package;
    
    # Optional configuration examples:
    # environment = {
    #   HOST = "0.0.0.0";  # Uncomment to expose on all interfaces
    #   WEBUI_AUTH = "False";  # Disable authentication for local development
    #   OLLAMA_API_BASE_URL = "http://localhost:11434";  # Required for Ollama integration
    # };
    
    # stateDir = "/var/lib/open-webui";  # Recommended persistent storage location
  };
}

    # environment.systemPackages = with pkgs-unstable; [
  #   open-webui
  # ];

  # services.open-webui = {
  #   enable = true;
  #   port = 8080;
  #   package = pkgs-unstable.open-webui;
  #   # stateDir = "/run/media/asyu/Vault/Web-ui";
  #   #environmentFile = "/run/media/asyu/Vault/Web-ui/secret/openai.txt";
  #   environment = {
  #     # HOST = "0.0.0.0";
  #     # WEBUI_AUTH = "False";
  #     #   ENABLE_IMAGE_GENERATION = "$ENABLE_IMAGE_GENERATION";
  #     #   IMAGE_GENERATION_MODEL = "$IMAGE_GENERATION_MODEL";
  #     #   ENABLE_RAG_WEB_SEARCH = "$ENABLE_RAG_WEB_SEARCH";
  #     #   RAG_WEB_SEARCH_ENGINE = "$RAG_WEB_SEARCH_ENGINE";
  #     #   AUDIO_STT_ENGINE = "$AUDIO_STT_ENGINE";
  #     #   AUDIO_STT_MODEL = "$AUDIO_STT_MODEL";
  #     #   AUDIO_TTS_ENGINE = "$AUDIO_TTS_ENGINE";
  #     #   AUDIO_TTS_VOICE = "$AUDIO_TTS_VOICE";
  #     #   ENABLE_EVALUATION_ARENA_MODELS = "$ENABLE_EVALUATION_ARENA_MODELS";
  #   };
  # };

