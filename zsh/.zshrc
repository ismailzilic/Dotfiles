precmd() { echo; }

# Default editor
export EDITOR=nvim
export VISUAL="$EDITOR"

# zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Starship setup
if command -v starship >/dev/null 2>&1; then
	fastfetch
else
    echo "Starship is not installed. Starting installation..."
	echo "If something breaks, refer to the official Starship installation guide!"
    curl -sS https://starship.rs/install.sh | sh
fi

# ssh-agent startup
eval "$(ssh-agent -s)"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias ls='ls --color'
alias c='clear'
alias v='nvim'
alias vi='nvim'
alias reflector='sudo reflector --latest 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist'

# Starship setup & starship theme preset load
eval "$(starship init zsh)"
starship preset plain-text-symbols -o ~/.config/starship.toml
