# ----------------------------------------------------------------
# 		      Environment Variables
# ----------------------------------------------------------------

set -o vi

export EDITOR=nvim
export VISUAL=nvim
export TERM="tmux-256color"

export DOTFILES="$HOME/Dotfiles"
export CODEBASE="$HOME/Codebase"
export PLUGINS="$HOME/.config/zsh-plugins"


# ----------------------------------------------------------------
# 			     History
# ----------------------------------------------------------------

HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=30000
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# ----------------------------------------------------------------
# 			     Prompt
# ----------------------------------------------------------------

PURE_PATH=$DOTFILES/zsh/pure

if [ ! -d "$PURE_PATH" ]; then
	mkdir "$PURE_PATH"
	echo "Couldn't find a defined directory for 'Pure Prompt'."
	echo "Created a new directory for 'Pure Prompt' at: $PURE_PATH"
fi

fpath+=($PURE_PATH)

autoload -U promptinit; promptinit
prompt pure


# ----------------------------------------------------------------
# 			     Homebrew
# ----------------------------------------------------------------

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# ----------------------------------------------------------------
# 			   Local Aliases
# ----------------------------------------------------------------

source $DOTFILES/zsh/zsh-includes/user-aliases.zsh


# ----------------------------------------------------------------
# 			     Aliases
# ----------------------------------------------------------------

alias v="nvim"

alias c="clear"
alias e="exit"

alias home="cd $HOME"
alias dot="cd $DOTFILES"
alias cb="cd $CODEBASE"

alias ls="ls --color"
alias la="ls -lahtr"

alias tnew="tmux new -s main"
alias tatt="tmux attach -t main"
alias tkill="tmux kill-session -t main"

alias gp="git pull"
alias gs="git status"

alias refresh="sudo dnf update --refresh"


# ----------------------------------------------------------------
# 			    Key Binds
# ----------------------------------------------------------------

bindkey -d
bindkey '^K' up-line-or-history
bindkey '^J' down-line-or-history   
bindkey '^F' autosuggest-accept


# ----------------------------------------------------------------
# 			   Completion
# ----------------------------------------------------------------

# Install Missing Packages
if [ ! rpm -q fzf > /dev/null 2>&1 ]; then
	echo "'fzf' not found. Installing..."
	yes | sudo dnf install -y fzf
fi


if [ ! rpm -q zoxide > /dev/null 2>&1 ]; then
	echo "'zoxide' not found. Installing..."
	yes | sudo dnf install -y zoxide
fi

# fzf & zoxide
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# fzf-tab
if [ ! -d "$PLUGINS/fzf-tab" ]; then
	echo "'fzf-tab' not found. Installing..."

	git clone https://github.com/Aloxaf/fzf-tab $PLUGINS/fzf-tab/
fi

# zsh-completions
if [ ! -d "$PLUGINS/zsh-completions" ]; then
	echo "'zsh-completions' not found. Installing..."

	git clone https://github.com/zsh-users/zsh-completions.git $PLUGINS/zsh-completions/
fi

fpath+=($PLUGINS/zsh-completions/src)

# zsh-autosuggestions
brew ls --versions zsh-autosuggestions || brew install zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completion Initialization
autoload -U compinit; compinit
source $PLUGINS/fzf-tab/fzf-tab.plugin.zsh

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

clear;
