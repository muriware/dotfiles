.PHONY: all install uninstall install-oh-my-zsh install-homebrew \
	install-homebrew-packages compile-terminfo \
	install-tmux-plugin-manager setup-symlinks cleanup-symlinks

PACKAGES ?= coreutils exiftool git mactex neovim node pandoc ripgrep tig tmux tree webp
CASKS ?= anki google-chrome iterm2 keepassxc rectangle slack

DOTFILES ?= $(shell ls -dp .[^.]* | grep -E '(\.dircolors|\.zshrc)')
CONFIG ?= $(shell ls .config/)
TERMINFO ?= $(shell ls .terminfo/)

define print_bold
	echo "\033[1m$(1)\033[0m"
endef

all: install

install: install-oh-my-zsh install-homebrew install-homebrew-packages \
	compile-terminfo setup-symlinks install-tmux-plugin-manager

HOMEBREW_UNINSTALL_SCRIPT :=https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh

uninstall:
	@$(call print_bold,==> Starting the uninstallation process...)
	@$(call print_bold,==> Uninstalling Homebrew...)
	@brew list --cask | xargs brew uninstall --force
	@brew list | xargs brew uninstall --force --ignore-dependencies
	@/bin/bash -c "$$(curl -fsSL $(HOMEBREW_UNINSTALL_SCRIPT))"
	@$(call print_bold,==> Uninstalling Oh My Zsh...)
	@/bin/bash "$(ZSH)/tools/uninstall.sh" 
	@make cleanup-symlinks
	@$(call print_bold,==> Removing additional configuration directories...)
	@rm -rfv $(HOME)/.cache
	@rm -rfv $(HOME)/.config
	@rm -rfv $(HOME)/.local
	@rm -rfv $(HOME)/.npm
	@rm -rfv $(HOME)/.ssh
	@rm -rfv $(HOME)/.terminfo
	@rm -rfv $(HOME)/.tig_history
	@rm -rfv $(HOME)/.vim
	@rm -rfv $(HOME)/.viminfo
	@rm -rfv $(HOME)/.zcompdump-unicorns-5.8.1
	@rm -rfv $(HOME)/.zcompdump-unicorns-5.8.1.zwc
	@rm -rfv $(HOME)/.zsh_history
	@rm -rfv $(HOME)/.zsh_sessions
	@$(call print_bold,==> Uninstallation process complete.)

OH_MY_ZSH_INSTALL_SCRIPT := https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

ZSH_AUTOSUGGESTIONS_DIR := $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions
ZSH_AUTOSUGGESTIONS_REPO := https://github.com/zsh-users/zsh-autosuggestions

ZSH_SYNTAX_HIGHLIGHTING_DIR := $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGNTING_REPO := https://github.com/zsh-users/zsh-syntax-highlighting

install-oh-my-zsh:
	@$(call print_bold,==> Installing Oh My Zsh...)
	@/bin/bash -c "$$(curl -fsSL $(OH_MY_ZSH_INSTALL_SCRIPT))" "" --unattended
	@$(call print_bold,==> Installing Oh My Zsh plugins...)
	@$(call print_bold,==> Installing Zsh Autosuggestions...)
	@git clone $(ZSH_AUTOSUGGESTIONS_REPO) $(ZSH_AUTOSUGGESTIONS_DIR)
	@$(call print_bold,==> Installing Zsh Syntax Highlighting...)
	@git clone $(ZSH_SYNTAX_HIGHLIGNTING_REPO) $(ZSH_SYNTAX_HIGHLIGHTING_DIR)
	@# compaudit | xargs chmod g-w,o-w
	@$(call print_bold,==> Oh My Zsh installation complete.)

HOMEBREW_INSTALL_SCRIPT := https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

install-homebrew:
	@$(call print_bold,==> Installing Homebrew...)
	@/bin/bash -c "$$(curl -fsSL $(HOMEBREW_INSTALL_SCRIPT))"
	@brew analytics off
	@$(call print_bold,==> Homebrew installation complete.)

define install-brew-item
	if ! brew list --$(1) $(2) > /dev/null 2>&1; then \
		brew install --$(1) $(2); \
	else \
		echo "$(2) is already installed."; \
	fi;
endef

install-homebrew-packages:
	@$(call print_bold,==> Installing Homebrew packages and casks...)
	@$(foreach package,$(PACKAGES),$(call install-brew-item,formula,$(package)))
	@$(foreach cask,$(CASKS),$(call install-brew-item,cask,$(cask)))
	@brew cleanup
	@$(call print_bold,==> Homebrew packages and casks installation complete.)

define compile-terminfo-file
	if [ -f "$(PWD)/.terminfo/$(1)" ]; then \
		echo "Compiling $(1)"; \
		tic -x $(PWD)/.terminfo/$(1); \
	else \
		echo "File not found: $(1)"; \
	fi;
endef

compile-terminfo:
	@$(call print_bold,==> Compiling Terminfo files...)
	@$(foreach terminfo_file,$(TERMINFO),$(call compile-terminfo-file,$(terminfo_file)))
	@$(call print_bold,==> Finished compiling Terminfo files.)

TPM_DIR := $(HOME)/.config/tmux/plugins/tpm
TPM_REPO := https://github.com/tmux-plugins/tpm

install-tmux-plugin-manager:
	@$(call print_bold,==> Installing Tmux Package Manager (TMP)...)
	@if [ ! -d "$(TPM_DIR)" ]; then \
		git clone $(TPM_REPO) $(TPM_DIR); \
		$(call print_bold,==> TPM installation complete.); \
	else \
		echo "TPM is already installed."; \
	fi

# Function to create a symbolic link
define create_link_with_checks
	if [ -e "$(PWD)/$(1)" ]; then \
		if [ -L "$(HOME)/$(1)" ]; then \
			echo "Removing existing symlink: $(HOME)/$(1)"; \
			unlink "$(HOME)/$(1)"; \
		elif [ -e "$(HOME)/$(1)" ]; then \
			echo "Backing up existing file/directory: $(HOME)/$(1).bak"; \
			mv "$(HOME)/$(1)" "$(HOME)/$(1).bak"; \
		fi; \
		ln -fsv "$(PWD)/$(1)" "$(HOME)/$(1)"; \
	else \
		echo "Source path does not exist: $(PWD)/$(1)"; \
	fi;
endef

setup-symlinks:
	@$(call print_bold,==> Creating symbolic links...)
	@# Ensure the .config directory exists
	@mkdir -p $(HOME)/.config
	@$(foreach dotfile,$(DOTFILES),$(call create_link_with_checks,$(dotfile)))
	@$(foreach folder,$(CONFIG),$(call create_link_with_checks,.config/$(folder)))
	@$(call print_bold,==> Finished creating symbolic links.)

# Function to remove a symbolic link
define remove_link
	if [ -L "$(1)" ]; then \
		unlink "$(1)" && echo "Removed $(1)" || echo "Failed to remove $(1)"; \
	else \
		echo "Symbolic link does not exist: $(1)"; \
	fi;
endef

cleanup-symlinks:
	@$(call print_bold,==> Removing symbolic links...)
	@$(foreach dotfile,$(DOTFILES),$(call remove_link,$(HOME)/$(dotfile)))
	@$(foreach folder,$(CONFIG),$(call remove_link,$(HOME)/.config/$(folder)))
	@$(call print_bold,==> Finished removing symbolic links.)
