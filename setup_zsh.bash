if ! command -v stow &> /dev/null; then
    echo "GNU Stow is not installed. Please install it to continue."
    exit 1
fi

stow zsh

touch ~/.zprofile

echo "source ~/.core.zshrc" >> ~/.zprofile
