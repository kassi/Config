# echo .zshrc
# Run in login shells, interactive shells and terminal app
#
#     always        login, Term      login, Term      login, Term
#                                    interactive
#       v                                 v
# +-----------+    +-----------+    +-----------+    +-----------+
# |  .zshenv  | -> | .zprofile | -> |  .zshrc   | -> |  .zlogin  |
# +-----------+    +-----------+    +-----------+    +-----------+

bindkey -e
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e[3~" delete-char
WORDCHARS='*?_.[]~=&;!#$%^(){}<>'

HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

if [[ $TERM_PROGRAM == "iTerm.app" ]]; then
  if [[ -f ~/Library/Fonts/Hack\ Regular\ Nerd\ Font\ Complete.ttf ]]; then
    PROMPT='%F{016}%K{#606060}%f%k%K{#606060} %* %F{#a0a0a0}%f %B%~%b %F{#606060}%K{016}%f%k '
  fi
fi

[[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh" || true
[[ -s "/opt/homebrew/opt/asdf/asdf.sh" ]] && source "/opt/homebrew/opt/asdf/asdf.sh"

fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

zstyle ':completion:*' special-dirs true

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
