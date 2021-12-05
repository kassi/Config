# .zshenv
#
#     always        login, Term      login, Term      login, Term
#                                    interactive
#       v                                 v
# +-----------+    +-----------+    +-----------+    +-----------+
# |  .zshenv  | -> | .zprofile | -> |  .zshrc   | -> |  .zlogin  |
# +-----------+    +-----------+    +-----------+    +-----------+
# reset PATH to system if it has already been set
if [[ -z $SYSTEM_PATH ]]; then
  SYSTEM_PATH=$PATH
else
  PATH=$SYSTEM_PATH
fi
export PATH
export SYSTEM_PATH
export EDITOR=code
export BUNDLER_EDITOR="code"
export GEM_EDITOR="code"
export VISUAL=vim

# Disable Google Analytics for Homebrew
export HOMEBREW_NO_ANALYTICS=1
PATH=/opt/homebrew/bin:$PATH

# OSX: Make clean tarballs and more in Leopard
export COPYFILE_DISABLE=true

# ASDF
export ASDF_NPM_DEFAULT_PACKAGES_FILE=$HOME/.config/asdf/default-npm-packages
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE=$HOME/.config/asdf/default-python-packages
export ASDF_GEM_DEFAULT_PACKAGES_FILE=$HOME/.config/asdf/default-gem-packages

# Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

### Java
export JAVA_HOME=/Library/Java/Home
PATH=${JAVA_HOME}:$PATH

### MySQL
export MYSQL_HOME=/opt/homebrew/opt/mysql@5.7/bin
# export DYLD_LIBRARY_PATH=/opt/homebrew/mysql/lib:$DYLD_LIBRARY_PATH
PATH=${MYSQL_HOME}:$PATH

### Ruby
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# set up vars for keg-only libraries installed via homebrew
LDFLAGS=()
CPPFLAGS=()
PKG_CONFIG_PATH=()
for lib in "icu4c" "openssl@1.1" "readline" "libpq"; do
  LDFLAGS+=(-L/opt/homebrew/opt/$lib/lib)
  CPPFLAGS+=(-I/opt/homebrew/opt/$lib/include)
  PKG_CONFIG_PATH+=(/opt/homebrew/opt/$lib/lib/pkgconfig)
done
for lib in "openssl@1.1" "libpq"; do
  PATH=/opt/homebrew/opt/$lib/bin:$PATH
done
LDFLAGS="$LDFLAGS"
CPPFLAGS="$CPPFLAGS"
PKG_CONFIG_PATH=${(j.:.)PKG_CONFIG_PATH}
export LDFLAGS
export CPPFLAGS
export PKG_CONFIG_PATH

PATH=$HOME/bin:/opt/homebrew/sbin:$PATH

[[ -r $HOME/.zsh/aliases ]] && . $HOME/.zsh/aliases
[[ -r $HOME/.zsh/functions ]] && . $HOME/.zsh/functions

