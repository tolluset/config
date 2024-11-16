if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# oh-my-zsh plugins
plugins=(
  z
  zsh-autosuggestions
  zsh-syntax-highlighting	
)

source $ZSH/oh-my-zsh.sh

# alias
alias cl='clear'

alias python='python3'
alias py='python3'
alias pip='pip3'
alias a='source .venv/bin/activate'
alias pl='pip list'
alias jn='jupyter notebook'
alias pcv='jupyter nbconvert --to script'
alias s='a;pl;jn'

alias st='streamlit'

alias sls='serverless'
alias cci='circleci'
alias g='git'
alias h='history'
alias dk='docker'
alias dc='docker compose'
alias p='pnpm'
alias pi='pnpm install'
alias px='pnpx'
alias as=". awsume"
# alias a="aws"
alias t="terraform"
alias ct="cdktf"
alias gs='git status'
alias y='yarn'
alias n='nvim'
alias b='bun'
alias bx='bunx'
alias bw='bun --watch'
alias pu='pulumi'
alias f='flutter'

alias sb='supabase'

alias c='cargo'

alias sz='source ~/.zshrc'

alias ls='lsd'
alias fz='fzf'
alias fk='fuck'

alias gb='BASE=$(git rev-parse --abbrev-ref @{-1})'
alias ghpc='gb;gh pr create --web -a @me -B $BASE'

alias i='wezterm imgcat'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# path
export PATH=/opt/homebrew/bin:$PATH


# pnpm
export PNPM_HOME=~/Library/pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

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

# the fuck
eval $(thefuck --alias)

# atuin
eval "$(atuin init zsh)"


# proto
export PROTO_HOME="$HOME/.proto"
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
export PROTO_AUTO_INSTALL=true

# maven
export MAVEN_HOME="$HOME/workspaces/apache-maven-3.9.9/bin"
export PATH="$PATH:$MAVEN_HOME"

# pipx
export PIPX_HOME=~/pipx
export PIPX_BIN_DIR=~/pipx/bin

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Created by `pipx` on 2024-11-16 13:20:04
export PATH="$PATH:/Users/bh/pipx/bin"
