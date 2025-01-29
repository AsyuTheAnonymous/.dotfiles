{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nodejs
  ];
  # shellHook = ''  
  
  # '';
  COLOR = "blue";



}
