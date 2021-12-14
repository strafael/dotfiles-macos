tmux attach &> /dev/null
if [ "$TMUX" = "" ]; then tmux; fi

#
# Functions
#

# Extract all kinds of archives
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Activate a virtualenv in the current directory
activate() {
  if [ -e "venv" ]; then
    source venv/bin/activate
  fi
  if [ -e ".venv" ]; then
    source .venv/bin/activate
  fi
}

#
# Aliases
#

# Allows to run the non-native version of homebrew from an non-Rosetta terminal
alias brew-x86='arch -x86_64 /usr/local/bin/brew'

# ls
alias ll='exa -l --icons --color=always --group-directories-first'
alias lla='exa -al --icons --color=always --group-directories-first'

# vim
alias vim=nvim

# Confirm before overwriting something
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Colorize the command output for ease of use
alias grep='grep -i --color=auto'
alias egrep='egrep -i --color=auto'
alias fgrep='fgrep -i --color=auto'
alias ps='grc ps'
alias ping='grc ping'
alias lsblk='grc lsblk'
alias du='grc du -h'
alias df='grc df -h'

# bare git repo for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

#
# Exports
#

export PATH=~/.emacs.d/bin:$PATH
export EDITOR=nvim

# Only allows pip to be executed inside virtual envs
export PIP_REQUIRE_VIRTUALENV=true

# Fix double Python virtualenv name
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Starship prompt
eval "$(starship init zsh)"

#
# Keybindings
#

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Jump around with z.sh
# Must be after starship, otherwise it adds characters to the prompt.
# Data file: $HOME/.z
. $HOME/.scripts/z.sh

