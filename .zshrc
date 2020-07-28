# .zshrc
# Run in login shells, interactive shells and terminal app
#
#     always        login, Term      login, Term      login, Term
#                                    interactive
#       v                                 v
# +-----------+    +-----------+    +-----------+    +-----------+
# |  .zshenv  | -> | .zprofile | -> |  .zshrc   | -> |  .zlogin  |
# +-----------+    +-----------+    +-----------+    +-----------+

[[ -r .zsh/aliases ]] && . .zsh/aliases
[[ -r .zsh/functions ]] && . .zsh/functions
