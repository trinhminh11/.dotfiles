
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

DOTFILESHOME="$HOME/.dotfiles"

# adding brew
if [[ $OSTYPE == darwin* ]]; then
    # initialize brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Check cargo installation
if ! command -v cargo >/dev/null 2>&1; then
    echo "⚠️ Cargo is not installed. Installing Rust (includes Cargo)..."
    eval "$DOTFILESHOME/scripts/setup.sh"
fi

if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

# # eza for printing tree folder
# if ! command -v eza >/dev/null 2>&1; then
#     echo "⚠️ eza is not installed. Installing eza..."
#     cargo install --locked eza
#     if [ $? -eq 0 ]; then
#         echo "✅ eza installed successfully."
#     else
#         echo "❌ Failed to install eza."
#     fi
# fi

# # zoxide for cd replacement
# if ! command -v zoxide >/dev/null 2>&1; then
#     echo "⚠️ zoxide is not installed. Installing zoxide..."
#     cargo install zoxide --locked
#     if [ $? -eq 0 ]; then
#         echo "✅ zoxide installed successfully."
#     else
#         echo "❌ Failed to install zoxide."
#     fi
# fi
# ====================================================================================================================================
# conda initialization, uncomment if you want conda initialization
# if [ -d "$DOTFILESHOME/conda" ]; then
#     . "$DOTFILESHOME/conda/conda.sh"
# fi
# ====================================================================================================================================
# if [ ! -d "$HOME/.fzf" ]; then
#     git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#     yes | ~/.fzf/install
# fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# ====================================================================================================================================
# uv installation for python
if [ ! -f "$HOME/.local/bin/uv" ]; then
    echo "⚠️ uv is not installed. run $DOTFILESHOME/scripts/setup.sh to install uv"
fi
# ====================================================================================================================================
# all zinit config and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME}/.local/share/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    echo "Zinit is not installed, installing Zinit..."
    eval "$DOTFILESHOME/scripts/setup.sh"
fi

source "$ZINIT_HOME/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# uncomment if you want conda zsh completion
# zinit light conda-incubator/conda-zsh-completion

# ====================================================================================================================================

# Key binding
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Load environment variables
export __BIRTHDAY__="11042004"
. "$HOME/.local/bin/env"

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt share_history            # Share History Between All Sessions.
setopt hist_ignore_dups         # Do Not Record An Event That Was Just Recorded Again.
setopt hist_ignore_all_dups     # Delete An Old Recorded Event If A New Event Is A Duplicate.
setopt hist_find_no_dups        # Do Not Display A Previously Found Event.
setopt hist_ignore_space        # Do Not Record An Event Starting With A Space.
setopt hist_save_no_dups        # Do Not Write A Duplicate Event To The History File.

chmod -R +x "$DOTFILESHOME/bin/"
export PATH="$PATH:$DOTFILESHOME/bin/"

# Pure prompt
PURE_GIT_PULL=0
if [[ $OSTYPE == darwin* ]]; then
    puredir="$(brew --prefix)/share/zsh/site-functions"
    fpath+=("$puredir")
else
    puredir="$HOME/.zsh/pure"
    fpath+=("$puredir")
fi

cp "$DOTFILESHOME/scripts/prompt_pure_setup" "$puredir/prompt_pure_setup"
unset puredir

autoload -Uz promptinit; promptinit
prompt pure

zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:fetch only_upstream yes
# ====================================================================================================================================

# Load custom environment variables
if [ -f "$HOME/.local/bin/env" ]; then
    . "$HOME/.local/bin/env"
fi

# alias
if [ -f "$DOTFILESHOME/aliases/.alias.sh" ]; then
    . "$DOTFILESHOME/aliases/.alias.sh"
fi


zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# Load zsh autocompletions
autoload -Uz compinit && compinit
zinit cdreplay -q

eval "$(zoxide init --cmd cd zsh)"
