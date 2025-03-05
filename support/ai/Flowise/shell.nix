{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "flowise-dev-shell";

  buildInputs = [
    pkgs.nodejs-18_x  # Adjust as needed; your log shows nodejs-20.18.1 in use
    pkgs.pnpm         # Optional: if you plan on using pnpm for other tasks
    pkgs.git          # Useful for cloning and version control
  ];

  shellHook = ''
    # Define repository variables
    REPO_DIR="Flowise"
    REPO_URL="https://github.com/FlowiseAI/Flowise.git"

    # Check if the Flowise repo is already cloned
    if [ ! -d "$REPO_DIR" ]; then
      echo "Cloning Flowise repository..."
      git clone "$REPO_URL" "$REPO_DIR"
      cd Flowise
      pnpm install
      pnpm build
    else
      echo "Directory '$REPO_DIR' already exists."
      read -p "Do you want to overwrite it? (y/n): " answer
      if [ "$answer" = "y" ]; then
        rm -rf "$REPO_DIR"
        echo "Cloning Flowise repository..."
        git clone "$REPO_URL" "$REPO_DIR"
        cd Flowise
        pnpm install
        pnpm build
      else
        echo "Using existing repository."
        cd Flowise
        echo "Use pnpm start to run flowise."
      fi
    fi
  '';
}
