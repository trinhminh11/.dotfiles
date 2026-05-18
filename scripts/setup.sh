# cargo installation
if ! command -v cargo >/dev/null 2>&1; then
    echo "⚠️ Cargo is not installed. Installing Rust (includes Cargo)..."

    # Detect OS
    OS=$(uname -s)

    case "$OS" in
        Darwin|Linux)
            # Install Rust using rustup (official installer)
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            # Add cargo to PATH for current session
            export PATH="$HOME/.cargo/bin:$PATH"
            echo "✅ Rust and Cargo installed successfully."
            ;;
        *)
            echo "❌ Unsupported OS: $OS"
            exit 1
            ;;
    esac
    if [ "$OS" == "Linux" ]; then
        sudo apt install -y build-essential
    fi
fi


# eza for printing tree folder
if ! command -v eza >/dev/null 2>&1; then
    echo "⚠️ eza is not installed. Installing eza..."
    cargo install --locked eza
    if [ $? -eq 0 ]; then
        echo "✅ eza installed successfully."
    else
        echo "❌ Failed to install eza."
    fi
fi


# zoxide for cd replacement
if ! command -v zoxide >/dev/null 2>&1; then
    echo "⚠️ zoxide is not installed. Installing zoxide..."
    cargo install zoxide --locked
    if [ $? -eq 0 ]; then
        echo "✅ zoxide installed successfully."
    else
        echo "❌ Failed to install zoxide."
    fi
fi


if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    yes | ~/.fzf/install
fi


# uv installation for python
if [ ! -f "$HOME/.local/bin/uv" ]; then
    eval "curl -LsSf https://astral.sh/uv/install.sh | sh"
fi


if [ ! -d "$ZINIT_HOME" ]; then
    echo "Cloning Zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


# Check if the font is already installed
if ! fc-list | grep -i "FiraCode Nerd Font" > /dev/null; then
    __fontname="FiraCode Nerd Font"
    __fontdir="$HOME/.local/share/fonts"
    __font_file="$__fontdir/FiraCode-Regular.ttf"
    __download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
    __temp_dir="/tmp/fira_code_nerd_font_install"

    # Create necessary directories
    mkdir -p "$__fontdir"
    mkdir -p "$__temp_dir"
    # Download and unzip the font
    echo "Downloading $__fontname..."
    curl -L -o "$__temp_dir/FiraCode.zip" "$__download_url"
    echo "Extracting font files..."
    unzip -o "$__temp_dir/FiraCode.zip" -d "$__temp_dir"
    # Move TTF files to font directory
    find "$__temp_dir" -iname "*FiraCode*.ttf" -exec cp {} "$__fontdir/" \;
    # Clean up

    rm -rf "$__temp_dir"
    # Refresh font cache
    echo "Updating font cache..."
    fc-cache -f "$__fontdir"
    echo "$__fontname installed successfully."

    unset __fontname
    unset __fontdir
    unset __font_file
    unset __download_url
    unset __temp_dir
fi

# Pure prompt
PURE_GIT_PULL=0
if [[ $OSTYPE == darwin* ]]; then
    puredir="$(brew --prefix)/share/zsh/site-functions"
    if [ ! -f "$puredir/prompt_pure_setup" ]; then
        brew install pure
    fi
else
    mkdir -p "$HOME/.zsh"
    puredir="$HOME/.zsh/pure"
    if [ ! -d "$puredir" ]; then
        git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    fi
fi
