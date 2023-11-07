SHELL = /bin/bash

update-brew:
	rm ~/.config/Brewfile
	brew bundle dump --describe

update-zshrc:
	rm ~/.zshrc
	ln ~/.config/.zshrc ~/.zshrc

