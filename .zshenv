# .zshenv
#
#     always        login, Term      login, Term      login, Term
#                                    interactive
#       v                                 v
# +-----------+    +-----------+    +-----------+    +-----------+
# |  .zshenv  | -> | .zprofile | -> |  .zshrc   | -> |  .zlogin  |
# +-----------+    +-----------+    +-----------+    +-----------+
export PATH
export EDITOR=code
export BUNDLER_EDITOR="code"
export VISUAL=vim

# Disable Google Analytics for Homebrew
export HOMEBREW_NO_ANALYTICS=1

# OSX: Make clean tarballs and more in Leopard
export COPYFILE_DISABLE=true

# Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

### Java
export JAVA_HOME=/Library/Java/Home
PATH=${JAVA_HOME}:$PATH

### MySQL
export MYSQL_HOME=/usr/local/opt/mysql@5.7/bin
# export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
PATH=${MYSQL_HOME}:$PATH

for lib in "icu4c" "openssl@1.1" "readline"; do
  LDFLAGS="$LDFLAGS -L/usr/local/opt/$lib/lib"
  CPPFLAGS="$CPPFLAGS -I/usr/local/opt/$lib/include"
  PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/$lib/lib/pkgconfig"
done
for lib in "openssl@1.1"; do
  PATH=/usr/local/opt/$lib/bin:$PATH
done
export LDFLAGS
export CPPFLAGS
export PKG_CONFIG_PATH
PATH=$HOME/bin:/usr/local/sbin:$PATH
PATH="$PATH:$HOME/.rvm/bin"

[[ -r $HOME/.zsh/aliases ]] && . $HOME/.zsh/aliases
[[ -r $HOME/.zsh/functions ]] && . $HOME/.zsh/functions
