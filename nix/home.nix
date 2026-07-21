{ pkgs, ... }:
let
  # マシンごとのユーザー名/ホームディレクトリを環境変数から取得
  # （複数マシンで同じ設定を使い回すため）
  # 評価には --impure が必要（home-manager switch --flake ... --impure）
  username = builtins.getEnv "USER";
  homeDirectory = builtins.getEnv "HOME";
in {
  home.username = username;
  home.homeDirectory = homeDirectory;
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
    herdr

    # Editor
    neovim

    # Dev tools
    mise
    deno

    # Media
    ffmpeg

    # Container
    colima
    docker
    docker-compose
  ];
}
