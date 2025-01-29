{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nodejs
    python311
  ];
  inputsFrom = [ pkgs.bat ];
  # shellHook = ''  
  
  # '';
  COLOR = "blue";



}
