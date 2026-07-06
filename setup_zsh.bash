if ! command -v stow &> /dev/null; then
    echo "GNU Stow is not installed. Installing..."
    sudo apt-get install stow -y
    exit 1
fi

if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Installing..."
    sudo apt-get install zsh -y
    exit 1
fi

if [ -f "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

stow zsh

touch "$HOME/.zprofile"

if grep -qF "source ~/.core.zshrc" ~/.zprofile; then
    :
else
    echo "source ~/.core.zshrc" >> "$HOME/.zprofile"
fi

zsh


source "$HOME/.zprofile"

echo "Zsh setup complete. Please restart your computer to apply permanent changes. You can also run 'source ~/.zprofile' to apply changes immediately."
