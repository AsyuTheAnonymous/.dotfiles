{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nodejs
    python311
    python311Packages.pip
    python311Packages.envs
    python311Packages.ollama

  ];
  inputsFrom = [ pkgs.bat ];
  # shellHook = ''  
  
  # '';
  COLOR = "blue";



}
