if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# oh-my-zsh plugins
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting	
)

source $ZSH/oh-my-zsh.sh

# alias
alias sz='source ~/.zshrc'

alias c='clear'

alias python='python3'
alias py='python3'
alias pip='pip3'
alias g='git'
alias h='history'
alias dk='docker'
alias dc='docker compose'
alias p='pnpm'
alias px='pnpx'
alias as=". awsume"
alias a="aws"
alias gs='git status'
alias y='yarn'
alias n='nvim'
alias b='bun'
alias f='flutter'
alias pr='proto'

alias ls='lsd'
alias fz='fzf'
alias fk='fuck'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# path
export PATH=/opt/homebrew/bin:$PATH

# Created by `pipx` on 2023-11-07 13:53:03
export PATH="$PATH:~/.local/bin"

# pnpm
export PNPM_HOME=~/Library/pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# flutter
export PATH="$PATH:$HOME/flutter/bin"

## pub global
export PATH="$PATH":"$HOME/.pub-cache/bin"

# zoxide
eval "$(zoxide init zsh)"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


eval $(thefuck --alias)

eval "$(atuin init zsh)"

# Init Homebrew, which adds environment variables
eval "$(brew shellenv)"

fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)

# Then choose one of these options:
# 1. If you're using Oh My Zsh, you can initialize it here
source $ZSH/oh-my-zsh.sh

# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
