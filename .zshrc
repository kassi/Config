# .zshrc
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

PROMPT='%F{016}%K{#606060}%f%k%K{#606060} %* %F{#a0a0a0}%f %B%~%b %F{#606060}%K{016}%f%k '

[[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh" || true
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "/usr/local/opt/asdf/asdf.sh" ]] && source "/usr/local/opt/asdf/asdf.sh"

fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

zstyle ':completion:*' special-dirs true

