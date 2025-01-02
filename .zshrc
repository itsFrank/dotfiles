# make sure zinit is installed
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# basic aliases
alias ls='eza'
alias ll='eza -la'
alias vi='nvim'

if [ -e $HOME/sourceme.sh ]; then
    source $HOME/sourceme.sh
fi

if [ -e $HOME/.keysrc ]; then
    source $HOME/.keysrc
fi


# prompt
eval "$(starship init zsh)"

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light joshskidmore/zsh-fzf-history-search

zinit snippet OMZP::git

# load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*:default' list-colors \
    "di=1;36" "ln=35" "so=32" "pi=33" "ex=31" "bd=34;46" "cd=34;43" \
    "su=30;41" "sg=30;46" "tw=30;42" "ow=30;43"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'

# history
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
# up/down search with prefix and cursor at end of line
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# shell integrations
eval $(fzf --zsh)
