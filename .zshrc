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
alias python='python3'
alias py='python3'
alias pip='pip3'
alias sls='serverless'
alias cci='circleci'
alias g='git'
alias h='history'
alias dk='docker'
alias dc='docker compose'
alias p='pnpm'
alias as=". awsume"
alias a="aws"
alias t="terraform"
alias ct="cdktf"
alias gs='git status'
alias y='yarn'
alias n='nvim'
alias b='bun'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# path
export PATH=/opt/homebrew/bin:$PATH

