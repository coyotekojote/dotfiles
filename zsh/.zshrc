# alias

alias ll='ls -la'

## git
alias gch='git checkout'
alias gd='git diff'
alias gdno='git diff --name-only'
alias gcm='git commit'
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

# 端末固有の設定ファイルがあれば読み込む
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
