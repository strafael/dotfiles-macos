echo "Running .profile..."

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

export EDITOR=nvim

# Disable bash deprecation warning
#export BASH_SILENCE_DEPRECATION_WARNING=1

# Only allows pip to be executed inside virtual envs
export PIP_REQUIRE_VIRTUALENV=true

# Fix double Python virtualenv name
export VIRTUAL_ENV_DISABLE_PROMPT=true

export PATH="$HOME/.poetry/bin:$PATH"
