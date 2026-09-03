if [ -f "$PWD/.env" ]; then
    . "$PWD/.env"
fi

if [ "${ZSETUP:-false}" = "true" ]; then
    :
else
    source "$HOME/.zprofile"
fi


tmux() {
    if [ "$#" -gt 0 ]; then
        command tmux "$@"
        return
    fi

    local dir_name
    local workspace_name
    local term_name

    dir_name="${PWD##*/}"

    # tmux auto-renames "." -> "_"
    dir_name="${dir_name//./_}"

    workspace_name="${dir_name}-workspace"
    term_name="${dir_name}-term"

    if [[ -n "$TMUX" ]]; then
        if [[ "$(command tmux display-message -p '#S')" == "$workspace_name" ]]; then
            if command tmux -L term has-session -t "=$term_name" 2>/dev/null; then
                env TMUX= command tmux -L term -f "$DOTFILESHOME/tmux/tmux_term.conf" attach-session -t "=$term_name"
            else
                env TMUX= command tmux -L term -f "$DOTFILESHOME/tmux/tmux_term.conf" new-session -s "$term_name"
            fi
        else
            echo "You are already in a tmux session named '$(command tmux display-message -p '#S')'."
        fi

    else
        if command tmux -L workspace has-session -t "=$workspace_name" 2>/dev/null; then
            command tmux -L workspace attach-session -t "=$workspace_name"
        else
            command tmux -L workspace new-session -s "$workspace_name"
        fi
    fi

}


prompt pure

