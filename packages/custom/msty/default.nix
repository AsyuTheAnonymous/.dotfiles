{
  appimageTools,
  fetchurl,
  makeWrapper,
}: let
  # Package name and version
  pname = "msty";
  version = "1.7";

  # Fetch the AppImage from Msty's website
  src = fetchurl {
    url = "https://assets.msty.app/prod/latest/linux/amd64/Msty_x86_64_amd64.AppImage";
    sha256 = "sha256-k6hcT7Dp53e4zWXXJhsonNlfOwCLIOo/kz8FcDq8OKo=";
  };

  # Extract the AppImage contents for icon and desktop file
  appimageContents = appimageTools.extractType2 {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    nativeBuildInputs = [makeWrapper];

    # Install desktop file and icon, fixing the Exec path
    extraInstallCommands = ''
      # Install desktop file
      install -m 444 -D ${appimageContents}/msty.desktop -t $out/share/applications

      # Fix desktop file Exec path
      substituteInPlace $out/share/applications/msty.desktop \
        --replace-warn "Exec=AppRun" "Exec=${pname}"

      # Install icon
      install -m 444 -D ${appimageContents}/msty.png \
        $out/share/icons/hicolor/256x256/apps/msty.png

      # Wrap the binary with GNOME desktop environment
      wrapProgram $out/bin/${pname} \
        --set XDG_CURRENT_DESKTOP GNOME
    '';
  }
