{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nodejs
  ];
  shellHook = ''
    echo = "Whalecum"
  
  
  '';
  COLOR = "blue";



}
