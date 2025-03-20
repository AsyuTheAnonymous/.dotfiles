{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ollama-cuda
  ];
  # Ollama + Location
  services.ollama = {
    enable = true;
    models = "$MODELS_PATH";
  };

  environment.variables = {
    OPENAI_API_KEY = "$OPENAI_API_KEY";
    GROQ_API_KEY = "$GROQ_API_KEY";
    OLLAMA_API_BASE = "$OLLAMA_API_BASE";
    # AIDER_TIMEOUT = 10;
  };

  # Ollama Web Ui
  # services.nextjs-ollama-llm-ui = {
  #   enable = true;
  #   ollamaUrl = "http://127.0.0.1:11434";
  # };
}
