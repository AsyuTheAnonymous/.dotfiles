{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nodejs
    python311
  ];
  # shellHook = ''  
  
  # '';
  COLOR = "blue";



}
