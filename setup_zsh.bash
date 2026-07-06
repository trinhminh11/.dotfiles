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
if grep -qF "source ~/.core.zshrc" ~/.zprofile; then
    echo "source ~/.core.zshrc" >> "$HOME/.zprofile"
fi

source "$HOME/.zprofile"

echo "Zsh setup complete. Please restart your computer to apply permanent changes. You can also run 'source ~/.zprofile' to apply changes immediately."
