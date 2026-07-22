export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# nix
# /etc/zshenv (nix-installer生成) はSSH接続時のみnixを読み込むため、
# herdr等のローカルnon-interactiveシェル(zsh -c)ではnixのPATHが通らない。
# 全zshが読む.zshenvで無条件に読み込み、gh/peco/ghq等を利用可能にする。
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
