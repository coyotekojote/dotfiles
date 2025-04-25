# alias

alias ll='ls -la'

# git
alias gch='git checkout'
alias gd='git diff'
alias gdno='git diff --name-only'
alias gcm='git commit'
alias gl='git log'
alias glp='git log -p'
alias gpo='git push origin HEAD'

# gitのブランチ情報を表示する
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '(%b)'
PROMPT='%~ ${vcs_info_msg_0_} %# '

# path
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"


# peco
# ghq + peco でリポジトリに移動する関数
function peco-src() {
  # ghqで管理するリポジトリのパスを取得 (-p オプション) し、pecoに渡す
  # --query "$LBUFFER" で、現在のコマンドラインバッファの内容を初期クエリとする
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")

  # pecoで何かが選択された場合
  if [ -n "$selected_dir" ]; then
    # コマンドラインバッファ (BUFFER) に cd コマンドを設定
    # パスにスペースが含まれる場合を考慮し、適切に引用符を追加
    BUFFER="cd \"${selected_dir}\""
    # バッファの内容を実行する
    zle accept-line
  # else # オプション: キャンセル時の処理
    # zle send-break # Ctrl-C をシミュレートしてキャンセルを示す
  fi
  # 実行後またはキャンセル後、画面をクリアする
  zle clear-screen
}

# 定義した関数を Zsh Line Editor (zle) のウィジェットとして登録
zle -N peco-src

# キーバインドを設定 (^] は Ctrl + ])
bindkey '^]' peco-src



# 端末固有の設定ファイルがあれば読み込む
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
