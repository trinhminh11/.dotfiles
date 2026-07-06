if [ -f "$PWD/.env" ]; then
    . "$PWD/.env"
fi

if [ "${ZSETUP:-false}" = "true" ]; then
    :
else
    source "$HOME/.zprofile"
fi

prompt pure
