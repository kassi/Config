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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
conda deactivate
# <<< conda initialize <<<

if [[ $TERM_PROGRAM == "iTerm.app" || $TERM_PROGRAM == "vscode" ]]; then
  if [[ -f ~/Library/Fonts/HackNerdFont-Regular.ttf ]]; then
    autoload -Uz vcs_info
    precmd_python_info() {
      if [[ -n $POETRY_ACTIVE ]]; then
        _PYTHON_ENV="poetry"
      elif [[ -n $PIPENV_ACTIVE ]]; then
        _PYTHON_ENV="$VIRTUAL_ENV_PROMPT"
      elif [[ -n $VIRTUAL_ENV ]]; then
        _PYTHON_ENV="${VIRTUAL_ENV##*/}"
      elif [[ -n $CONDA_DEFAULT_ENV ]]; then
        _PYTHON_ENV=${CONDA_DEFAULT_ENV##*/}
      else
        _PYTHON_ENV=""
      fi
      if [[ -n $_PYTHON_ENV ]]; then
        PYTHON_ENV="%F{black}%K{#45af2d}   $_PYTHON_ENV %K{black}%F{#45af2d}%k%f"
      else
        PYTHON_ENV=""
      fi
    }
    DISABLE_AUTO_TITLE="true"
    tab_title() {
      echo -ne "\e]1;${PWD##*/}\a"
    }
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( tab_title precmd_python_info precmd_vcs_info )
    setopt prompt_subst

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla cvs svn
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "S"
    zstyle ':vcs_info:git:*' unstagedstr "U"
    zstyle ':vcs_info:git:*' formats '%K{black}%F{#c0c000} %F{black}%K{#c0c000}  %b [%c%u%m] %K{black}%F{#c0c000} %f%k'
    zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

    +vi-git-untracked() {
      if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
      then
        hook_com[misc]='?'
      fi
    }
    # %F{color}...%f - change foreground
    # %K{color}...%k - change background
    # %*: time
    # %1~: current dir

    PROMPT='%F{black}%K{#c0c000}%F{#303030} %* %F{black}%F{#303030} %B%1~%b %F{#c0c000}%K{black}%f%k$PYTHON_ENV '
    RPROMPT=\$vcs_info_msg_0_

  fi
  export ACTIVE_CONDA_PATH=""
  export ACTIVE_VENV_PATH=""
  cd() {
    builtin cd "$@" &&
    if [ -f $PWD/.conda-env ]; then
      if [ -z "$ACTIVE_CONDA_PATH" ]; then
        export ACTIVE_CONDA_PATH=$PWD
        conda activate $(cat .conda-env)
      fi
    elif [ "$ACTIVE_CONDA_PATH" ]; then
      if [[ $PWD != *"$ACTIVE_CONDA_PATH"* ]]; then
        export ACTIVE_CONDA_PATH=""
        conda deactivate
      fi
    fi &&
    if [ -f $PWD/.venv/bin/activate ]; then
      if [ -z "$ACTIVE_VENV_PATH" ]; then
        export ACTIVE_VENV_PATH=$PWD
        source $PWD/.venv/bin/activate
      fi
    elif [ "$ACTIVE_VENV_PATH" ]; then
      export ACTIVE_VENV_PATH=""
      deactivate
    fi
    # if [ -f $PWD/Pipfile.lock ]; then
    #   if [ -z "$ACTIVE_PIPENV_PATH" ]; then
    #     export ACTIVE_PIPENV_PATH=$PWD
    #     pipenv shell
    #   fi
    # elif [ "$ACTIVE_PIPENV_PATH" ]; then
    #   # no deactivate. need to CTRL-D to exit
    # fi
  }
  cd .
fi

# Hammerspoon invokes hs.execute(cmd, true) as interactive login shell.
# This causes outputs to contain iterm shell integration codes.
# To avoid, check if shell is coming from Hammerspoon and if yes, don't load iterm shell integration.
parent=$(ps -p $PPID -o command=|grep Hammerspoon)
[[ -z $parent ]] && [[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh" || true

fpath=(${ASDF_DIR}/completions $fpath)

source /Users/Kassi/.config/op/plugins.sh
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# Created by `pipx` on 2024-05-27 16:09:55
export PATH="$PATH:/Users/Kassi/.local/bin"
