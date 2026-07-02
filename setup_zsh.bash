if ! command -v stow &> /dev/null; then
    echo "GNU Stow is not installed. Please install it to continue."
    exit 1
fi

if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

stow zsh

touch "$HOME/.zprofile"

echo "source ~/.core.zshrc" >> "$HOME/.zprofile"

source "$HOME/.zprofile"
