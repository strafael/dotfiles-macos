export PATH="$HOME/.emacs.d/bin:$HOME/.local/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR=nvim

# Only allows pip to be executed inside virtual envs
export PIP_REQUIRE_VIRTUALENV=true

# Fix double Python virtualenv name
export VIRTUAL_ENV_DISABLE_PROMPT=true

# LDFLAGS
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"

# Keyring
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# Secrets
source ~/.secrets

