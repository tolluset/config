# alias

alias f='fish'

alias sz='source ~/.zshrc'
alias cf='n ~/.config/fish/config.fish'

alias python='python3'
alias py='python3'
alias pip='pip3'
alias pvs='py -m venv .venv'
alias pv='set -g VIRTUAL_ENV .venv'

alias g='git'
alias gt='serie'
alias h='history'
alias dk='docker'
alias dc='docker compose'
alias p='pnpm'
alias pi='pnpm install'
#alias ps='pnpm start'

alias npx='npx -y'

alias psm='pnpm start:mock'
alias psd='pnpm start:demo'
alias px='pnpm dlx'
alias t='npx vitest'

alias co='concurrently'

# project
alias dev='co "pnpm --filter browser-app dev:mock" "pnpm --filter browser-app storybook"'
alias ci='time co "turbo run lint" "turbo run spell-check -- --quiet" ".idea/cld"'
alias cit='time turbo run type-check test --filter browser-app'
alias cif='time co "turbo run lint" "turbo run spell-check -- --quiet" ".idea/cld" --names "lint,spell,tw" --prefix-colors "cyan,magenta,red"; or true; and time turbo run type-check test --filter browser-app'

# others

alias as="source (which awsume.fish)"

alias ghn="cd ~/workspaces/ && go run gh.go"

function l
    set -l cows (cowsay -l | string split ' ' | string match -v '')
    fortune | cowsay -f (random choice $cows) | lolcatjs
end

function mm
    g swm && g fp && g sw -
end

function dsp
    g ds | pbcopy
end

function ga
    set -l pattern $argv[1]
    set -l files (git status --porcelain | grep -i "$pattern" | awk '{print $2}')

    if test -n "$files"
        for file in $files
            git add "$file"
            echo "Added: $file"
        end
    else
        echo "No files matching '$pattern' found"
    end
end

#function as
#    . awsume $argv
#end

#function awsume
#    bass source (which awsume) $argv
#end

alias a="aws"
alias gs='git status'
alias y='yarn'
alias n='nvim'
alias b='bun'
#alias f='flutter'
alias pr='proto'

alias fz='fzf'
alias fk='fuck'

function gb
    set -g BASE (git rev-parse --abbrev-ref @{-1})
    echo $BASE
end

function ghpc
    gb
    gh pr create --web -a @me -B $BASE
end

function m
    g swm | g fp | g sw -
end

function s
    p --filter browser-app storybook:build && p --filter browser-app storybook
end

alias avt='av tree'
alias avn='av next'
alias anp='av prev'
alias avr='av reparent'
alias avb='av branch'

alias ch='chamgo'

alias c='claude --permission-mode plan'
alias cc='ccusage'
alias cm='claude-monitor'

alias ge='gemini'
# local
fish_add_path ~/.local/bin

# homebrew
fish_add_path /opt/homebrew/bin

# pnpm
set -gx PNPM_HOME ~/Library/pnpm
fish_add_path $PNPM_HOME

# rust
fish_add_path ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# cargo 별칭 설정
function ca --description "cargo 별칭"
    cargo $argv
end

function car --description "cargo run 별칭"
    cargo run $argv
end

function cab --description "cargo build 별칭"
    cargo build $argv
end

function cac --description "cargo check 별칭"
    cargo check $argv
end

function caa --description "cargo add 별칭"
    cargo add $argv
end

# AWS 및 Claude 설정
set -x AWS_REGION us-east-1
#set -x CLAUDE_CODE_USE_BEDROCK 1
#set -x DISABLE_PROMPT_CACHING 1
#set -x ANTHROPIC_MODEL 'us.anthropic.claude-3-7-sonnet-20250219-v1:0'

# Gemini
set -x GOOGLE_CLOUD_PROJECT lee-byonghun
set -x GOOGLE_CLOUD_LOCATION us-central1 # e.g., us-central1
set -x GOOGLE_GENAI_USE_VERTEXAI true

set -gx GEMINI_CLI_TELEMETRY_ENABLED false
set -gx OTEL_SDK_DISABLED true

# activate
mise activate fish | source
atuin init fish | source
