{ pkgs, ... }: {
  home.username = "coyotekojote";
  home.homeDirectory = "/Users/coyotekojote";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # CLI tools
    gh
    ghq
    peco
    sheldon
    tree
    yt-dlp
    rclone
    hugo
    gemini-cli

    # Editor
    neovim

    # Dev tools
    deno

    # Media
    ffmpeg

    # Container
    colima
    docker
    docker-compose
  ];
}
