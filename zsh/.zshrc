# ----------------------------------------------------------------
# 		      Environment Variables
# ----------------------------------------------------------------

set -o vi

export EDITOR=nvim
export VISUAL=nvim
export TERM="tmux-256color"

export DOTFILES="${HOME}/Dotfiles"
export PROJECTS="${HOME}/Projects"


# ----------------------------------------------------------------
# 			     History
# ----------------------------------------------------------------

HISTFILE=${HOME}/.zsh_history
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
# 			      Zinit
# ----------------------------------------------------------------

# Install Zinit if missing
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit

# Load plugins
if [[ $+commands[fzf] ]]; then
	eval "$(fzf --zsh)"
fi

if [[ $+commands[zoxide] ]]; then
	eval "$(zoxide init zsh --cmd cd)"
fi

zinit ice lucid wait blockf
zinit light zsh-users/zsh-completions

zinit ice lucid wait
zinit light Aloxaf/fzf-tab

zinit ice lucid wait'1'
zinit light zsh-users/zsh-autosuggestions

# Load prompt
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure


# ----------------------------------------------------------------
# 		       Additional config
# ----------------------------------------------------------------

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*' menu no


# ----------------------------------------------------------------
# 			     Aliases
# ----------------------------------------------------------------

alias c="clear"
alias e="exit"

alias ls="ls --color"
alias la="ls -lahtr"

alias tnew="tmux new -s main"
alias tatt="tmux attach -t main"
alias tkill="tmux kill-session -t main"


# ----------------------------------------------------------------
# 			    Key Binds
# ----------------------------------------------------------------

bindkey '^K' up-line-or-history
bindkey '^J' down-line-or-history   
bindkey '^F' autosuggest-accept
