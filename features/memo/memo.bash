
__feature_memo() {
    local file="$XDG_CONFIG_HOME/bash/features/memo/memo"
    local editor

    if [[ -n "$EDITOR" ]]; then
        editor="$EDITOR"
    else
        for editor in nvim vim nano ""; do
            [[ -n "$editor" ]] && command -v "$editor" >/dev/null 2>&1 && break
        done
    fi

    if [[ -z "$editor" ]]; then
        echo "memo: no editor found (EDITOR, nvim, vim, nano)" >&2
        return 1
    fi

    [[ -e "$file" ]] || touch "$file"

    $editor "$file"
}
