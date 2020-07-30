# .zshrc
# Run in login shells, interactive shells and terminal app
#
#     always        login, Term      login, Term      login, Term
#                                    interactive
#       v                                 v
# +-----------+    +-----------+    +-----------+    +-----------+
# |  .zshenv  | -> | .zprofile | -> |  .zshrc   | -> |  .zlogin  |
# +-----------+    +-----------+    +-----------+    +-----------+

[[ -r $HOME/.zsh/aliases ]] && . $HOME/.zsh/aliases
[[ -r $HOME/.zsh/functions ]] && . $HOME/.zsh/functions

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


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

