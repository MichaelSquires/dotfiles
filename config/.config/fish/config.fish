# vim keybindings
fish_vi_key_bindings

# Suppress the VIM indicator
function fish_mode_prompt
end

# Custom keybindings
bind -M insert \cd ignore-eof

# Aliases
alias vi=nvim

# Variables
set fish_greeting ""
set IGNOREEOF 1

# Exported variables
set -x EDITOR nvim
set -x HOMEBREW_NO_ANALYTICS 1
set -ax PATH ~/.local ~/.cargo/bin
