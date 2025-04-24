{ packages, ... }: {
    environment.systemPackages = with pkgs; [
        warp-terminal
    ];

}