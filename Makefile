.PHONY: all install uninstall clean brew packages casks terminfo tpm omz link unlink

PACKAGES ?= coreutils git node rbenv the_silver_searcher tig tmux tree vim
GPACKAGES ?= yarn
CASKS ?= alfred google-chrome iterm2 keepassxc rectangle slack the-unarchiver

DOTFILES ?= $(shell ls -dp .[^.]* | grep -v /)
TERMINFO ?= $(shell ls *.terminfo)

all: install

install: brew packages casks clean tpm ruby terminfo link omz

uninstall:
	@echo "==> Uninstalling casks..."
	brew uninstall --cask --force $(shell brew list --cask)
	@echo "==> Uninstalling packages..."
	brew uninstall --force --ignore-dependencies $(shell brew list)
	@echo "==> Uninstalling homebrew..."
	sudo /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
	@for file in ${DOTFILES} ; do \
	    rm -rfv $(HOME)/$$file ; \
	    done
	@rm -rfv $(HOME)/.config
	@rm -rfv $(HOME)/.local
	@rm -rfv $(HOME)/.oh-my-zsh
	@rm -rfv $(HOME)/.rbenv
	@rm -rfv $(HOME)/.terminfo
	@rm -rfv $(HOME)/.tmux
	@rm -rfv $(HOME)/.vim
	@rm -rfv $(HOME)/.zsh_history
	@rm -rfv $(HOME)/.zsh_sessions

clean:
	@echo "==> Cleaning up..."
	brew cleanup

brew:
	@echo "==> Installing homebrew..."
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@echo "==> Opting out of homebrew's analytics..."
	brew analytics off

packages:
	@echo "==> Installing packages..."
	@for package in ${PACKAGES} ; do \
	    brew install $$package ; \
	    done
	@echo "==> Installing npm global packages..."
	@for gpackage in ${GPACKAGES} ; do \
	    npm install -g $$gpackage ; \
	    done

casks:
	@echo "==> Installing casks..."
	@for cask in ${CASKS} ; do \
	    brew install --cask $$cask ; \
	    done

tpm:
	@echo "==> Installing tmux package manager..."
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ruby:
	@echo "==> Installing ruby..."
	rbenv install 3.0.0
	rbenv global 3.0.0

terminfo:
	@echo "==> Installing terminfo..."
	@for file in ${TERMINFO} ; do \
	    tic -x $$file ; \
	    done

omz:
	@echo "==> Installing oh-my-zsh..."
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	compaudit | xargs chmod g-w,o-w

link:
	@echo "==> Creating links..."
	@mkdir -p $(HOME)/.vim
	@ln -fsv $(PWD)/vim/init $(HOME)/.vim
	@for file in ${DOTFILES} ; do \
	    ln -fsv $(PWD)/$$file $(HOME)/$$file ; \
	    done

unlink:
	@echo "==> Removing links..."
	@rm -rfv $(HOME)/.vim/init
	@for file in ${DOTFILES} ; do \
	    rm -rfv $(HOME)/$$file ; \
	    done
