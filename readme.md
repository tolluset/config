# config

## alacritty

- Install `MesloLGSDZ Nerd` fonts

`curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.tar.xz && mkdir Meslo && tar -xf Meslo.tar.xz -C ./Meslo && rm Meslo.tar.xz`

## nvim

- Using lazyvim
- Should setup the following:

`:Copilot auth`

## tmux

- `tumx new`
- `cmd + b + "` \* 3
- `cmd + b + space`
- `cmd + b > opt + b ↓`

## .gitconfig

- Make hard link

`ln ~/.config/.gitconfig ~/.gitconfig`

## brew

- Make brew file

`brew bundle dump --describe`

- Make hard link

`ln ~/.confing/Brewfile ~/Brewfile`

- Use brew file

`brew bundle install`

## zshrc

`ln ~/.config/.zshrc ~/.zshrc`
