if status is-interactive
    # Commands to run in interactive sessions can go here
end

status --is-interactive; and rbenv init - fish | source

starship init fish | source

zoxide init fish | source

#peco setting
set fish_plugins theme peco

function ghq_peco_repo
  set selected_repository (ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    echo " $selected_repository "
    commandline -f repaint
  end
end

function fish_user_key_bindings
  bind \cw peco_select_history
  bind \cg ghq_peco_repo
end

# node
status --is-interactive; and source (anyenv init -|psub)
set -x NODENV_ROOT $HOME/.anyenv/envs/nodenv
set -x PATH $HOME/.anyenv/envs/nodenv/bin $PATH
set -gx PATH $NODENV_ROOT/shims $PATH

# rbenv
status --is-interactive; and rbenv init - fish | source
