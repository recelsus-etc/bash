
path_dirs=(
    "$HOME/.local/bin"
)

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

export TERM="${TERM:-xterm-256color}"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export RANDFILE="$XDG_CONFIG_HOME/openssl/rnd"
export LESSHISTFILE=-

export HISTFILE="$XDG_STATE_HOME/bash/history"
export BASH_SESSION="$XDG_STATE_HOME/bash/sessions"
export TERMINFO="$XDG_DATA_HOME/terminfo"

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CONAN_HOME="$XDG_DATA_HOME/conan"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

completion_files=(
    /usr/share/git/completion/git-prompt.sh
    /usr/share/git-core/contrib/completion/git-prompt.sh
    "$XDG_CONFIG_HOME/bash/scripts/ai/completion.bash"
)

path_prefix=""

for dir in "${path_dirs[@]}"; do
    [[ -d "$dir" ]] || continue
    [[ ":$PATH:$path_prefix:" == *":$dir:"* ]] && continue

    path_prefix="${path_prefix:+$path_prefix:}$dir"
done

[[ -n "$path_prefix" ]] && export PATH="$path_prefix:$PATH"

unset path_dirs path_prefix dir

for file in "${completion_files[@]}"; do
    [[ -f "$file" ]] && source "$file"
done

for file in "$XDG_DATA_HOME"/bash_completion/*; do
    [[ -f "$file" ]] && source "$file"
done

unset completion_files file

PS1='\[\e[1;31m\][\u@\h \[\e[1;34m\]\W\[\e[1;36m\]$(__git_ps1 "(%s)" 2>/dev/null)\[\e[1;31m\]]\$ \[\e[m\]'
## green
#PS1='\[\e[1;32m\][\u@\h \[\e[1;34m\]\W\[\e[1;36m\]$(__git_ps1 "(%s)" 2>/dev/null)\[\e[1;32m\]]\$ \[\e[m\]'
## yellow
#PS1='\[\e[1;33m\][\u@\h \[\e[1;34m\]\W\[\e[1;36m\]$(__git_ps1 "(%s)" 2>/dev/null)\[\e[1;33m\]]\$ \[\e[m\]'
## magenta
#PS1='\[\e[1;35m\][\u@\h \[\e[1;34m\]\W\[\e[1;36m\]$(__git_ps1 "(%s)" 2>/dev/null)\[\e[1;35m\]]\$ \[\e[m\]'
## white
#PS1='\[\e[1;37m\][\u@\h \[\e[1;34m\]\W\[\e[1;36m\]$(__git_ps1 "(%s)" 2>/dev/null)\[\e[1;37m\]]\$ \[\e[m\]'

for file in "$XDG_CONFIG_HOME"/bash/features/*/*.bash; do
    [[ -f "$file" ]] && source "$file"
done

unset file

[[ -f "$XDG_CONFIG_HOME/bash/alias" ]] && source "$XDG_CONFIG_HOME/bash/alias"
