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
    echo "ZSETUP=true" >> "$HOME/.zprofile"
fi


zsh -c "source $HOME/.zprofile"

echo "$DOTFILESHOME"

if [ -f "$HOME/.config/tmux/tmux.conf" ]; then
    echo "Backing up existing tmux.conf to tmux.conf.bak"
    mv "$HOME/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf.bak"
fi

ln -s "$DOTFILESHOME/tmux/tmux.conf" ~/.config/tmux/tmux.conf

echo ""
echo "Zsh setup complete. Please restart your computer to apply permanent changes. You can also run 'source ~/.zprofile' to apply changes immediately."
echo ""
echo "If you use ghostty like me: run below command to link ghostty.conf"
echo "ln -s $DOTFILESHOME/ghostty/ghostty.conf ~/.config/ghostty/ghostty.conf"

sudo chsh -s "$(which zsh)" "$USER"

zsh
