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
alias gs='git status'
alias gl='git log'
alias s='g s'

function prs
    gh pr list --repo trancity-nebula/trancity-nebula-admin --author @me --state all --json url,title --template '{{range .}}- [{{.title}}]({{.url}}){{"\n"}}{{end}}' | tail -r
end

function no
    gh api notifications --jq '.[] | select(.unread == true) | {title: .subject.title, type: .subject.type, url: .subject.url}'
end

function ghn
    gh api notifications --jq '.[] | select(.unread == true) | {
        title: .subject.title, 
        type: .subject.type, 
        url: (.subject.url | sub("api\\.github\\.com/repos"; "github.com") | sub("/pulls/"; "/pull/") | sub("/issues/"; "/issue/"))
    }'
end

alias ghb='gh browse'

alias gt='serie'
alias h='history'
alias dk='docker'
alias dc='docker compose'
alias p='pnpm'
alias pi='pnpm install'
alias pf='p fix'
#alias ps='pnpm start'

alias pd='podman'

alias pm='podman'

alias npx='npx -y'

alias psm='pnpm start:mock'
alias psd='pnpm start:demo'
alias px='pnpm dlx'
alias t='npx vitest'

alias co='concurrently'

# project
alias dev='co "pnpm --filter browser-app dev:mock" "pnpm --filter browser-app storybook"'

## mock-backend only app
alias mk='VITE_API_URL=http://localhost:8080 VITE_MOCK=true pnpm --filter browser-app dev'
## mock-backend
alias mk1='tmux new-session -d -s mock1 "cd ~/workspaces/calta/mock-backend/ && p dev" \; split-window -h "VITE_API_URL=http://localhost:8080 VITE_MOCK=true pnpm --filter browser-app dev" \; attach'
## real-backend
alias mk2='tmux new-session -d -s mock2 "cd ~/workspaces/calta/trancity-nebula-admin/packages/admin-api/ && p dev" \; split-window -h "VITE_API_URL=http://localhost:3001 pnpm --filter browser-app dev" \; attach'

alias cil='time co "turbo run lint" "turbo run spell-check -- --quiet" ".idea/cld"'
alias cit='time turbo run type-check test --filter browser-app'
alias ci='time co "turbo run lint" "turbo run spell-check -- --quiet" ".idea/cld" --names "lint,spell,tw" --prefix-colors "cyan,magenta,red"; or true; and time turbo run type-check test --filter browser-app'

alias fin="p fix && ci"

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

alias avt='av tree'
alias avn='av next'
alias anp='av prev'
alias avr='av reparent'
alias avb='av branch'

alias ch='chamgo'

#alias c='set SHELL /opt/homebrew/bin/fish claude --permission-mode plan --dangerously-skip-permissions'
function c
    set -lx SHELL /opt/homebrew/bin/fish
    claude --permission-mode plan --dangerously-skip-permissions $argv
end
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

set -gx EDITOR nvim

# Gemini
set -x GOOGLE_CLOUD_PROJECT lee-byonghun
set -x GOOGLE_CLOUD_LOCATION us-central1 # e.g., us-central1
set -x GOOGLE_GENAI_USE_VERTEXAI true

set -gx GEMINI_CLI_TELEMETRY_ENABLED false
set -gx OTEL_SDK_DISABLED true

# activate
mise activate fish | source
atuin init fish | source
