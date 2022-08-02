if status is-interactive
    # Commands to run in interactive sessions can go here
end

status --is-interactive; and rbenv init - fish | source

starship init fish | source

zoxide init fish | source

#peco setting
set fish_plugins theme peco

function fish_user_key_bindings
  bind \cw peco_select_history
end
