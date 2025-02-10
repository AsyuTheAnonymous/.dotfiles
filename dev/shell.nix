{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nodejs
    python311
    python311Packages.pip
    python311Packages.envs
    python311Packages.ollama
    python311Packages.kivy
    python311Packages.tkinter
    python311Packages.pyinstaller

  ];
  # inputsFrom = [ pkgs.bat ];
  # shellHook = ''  
  
  # '';
  COLOR = "blue";



}
