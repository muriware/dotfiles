.PHONY: all install uninstall install-oh-my-zsh install-homebrew \
	install-homebrew-packages compile-terminfo \
	install-tmux-plugin-manager setup-symlinks cleanup-symlinks

PACKAGES ?= coreutils exiftool git mactex neovim node pandoc ripgrep tig tmux tree webp
CASKS ?= anki google-chrome iterm2 keepassxc rectangle slack

DOTFILES ?= $(shell ls -dp .[^.]* | grep -E '(\.dircolors|\.zshrc)')
CONFIG ?= $(shell ls .config/)
TERMINFO ?= $(shell ls .terminfo/)

# Status tracking flags
STATUS_DIR := $(HOME)/.dotfiles_status
OH_MY_ZSH_STATUS := $(STATUS_DIR)/oh_my_zsh_installed
HOMEBREW_STATUS := $(STATUS_DIR)/homebrew_installed
HOMEBREW_PACKAGES_STATUS := $(STATUS_DIR)/homebrew_packages_installed
TERMINFO_STATUS := $(STATUS_DIR)/terminfo_compiled
SYMLINKS_STATUS := $(STATUS_DIR)/symlinks_created
TPM_STATUS := $(STATUS_DIR)/tpm_installed

# Shell commands for visual feedback
SUCCESS_CMD := echo "\033[32m✓\033[0m"
FAIL_CMD := echo "\033[31m✗\033[0m"

define print_bold
	echo "\033[1m$(1)\033[0m"
endef

define print_step
	echo "\033[34m-->\033[0m \033[1m$(1)\033[0m"
endef

define print_error
	echo "\033[31mERROR:\033[0m $(1)" >&2
endef

define print_warning
	echo "\033[33mWARNING:\033[0m $(1)" >&2
endef

define print_info
	echo "\033[36mINFO:\033[0m $(1)"
endef

all: install

install: 
	@$(call print_bold,==> Starting installation process...)
	@mkdir -p $(STATUS_DIR)
	@$(MAKE) install-oh-my-zsh
	@$(MAKE) install-homebrew
	@$(MAKE) install-homebrew-packages
	@$(MAKE) compile-terminfo
	@$(MAKE) setup-symlinks
	@$(MAKE) install-tmux-plugin-manager
	@$(call print_bold,==> Installation process complete.)
	@if [ -f $(OH_MY_ZSH_STATUS) ] && [ -f $(HOMEBREW_STATUS) ] && \
	   [ -f $(HOMEBREW_PACKAGES_STATUS) ] && [ -f $(TERMINFO_STATUS) ] && \
	   [ -f $(SYMLINKS_STATUS) ] && [ -f $(TPM_STATUS) ]; then \
		$(call print_info,"All components were installed successfully."); \
	else \
		$(call print_warning,"Some components failed to install. Review the logs above."); \
		[ ! -f $(OH_MY_ZSH_STATUS) ] && $(call print_error,"Oh My Zsh installation failed."); \
		[ ! -f $(HOMEBREW_STATUS) ] && $(call print_error,"Homebrew installation failed."); \
		[ ! -f $(HOMEBREW_PACKAGES_STATUS) ] && $(call print_error,"Homebrew packages installation failed."); \
		[ ! -f $(TERMINFO_STATUS) ] && $(call print_error,"Terminfo compilation failed."); \
		[ ! -f $(SYMLINKS_STATUS) ] && $(call print_error,"Symlinks setup failed."); \
		[ ! -f $(TPM_STATUS) ] && $(call print_error,"Tmux Plugin Manager installation failed."); \
	fi

HOMEBREW_UNINSTALL_SCRIPT :=https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh

uninstall:
	@$(call print_bold,==> Starting the uninstallation process...)
	@$(call print_step,"Uninstalling Homebrew packages and casks...")
	-@if command -v brew &> /dev/null; then \
		brew list --cask 2>/dev/null | xargs -L1 brew uninstall --force --cask 2>/dev/null || true; \
		brew list --formula 2>/dev/null | xargs -L1 brew uninstall --force --ignore-dependencies 2>/dev/null || true; \
		$(call print_step,"Uninstalling Homebrew..."); \
		/bin/bash -c "$$(curl -fsSL $(HOMEBREW_UNINSTALL_SCRIPT))" || $(call print_error,"Failed to uninstall Homebrew."); \
	else \
		$(call print_info,"Homebrew is not installed."); \
	fi
	@$(call print_step,"Uninstalling Oh My Zsh...")
	-@if [ -d "$(HOME)/.oh-my-zsh" ]; then \
		ZSH="$(HOME)/.oh-my-zsh" /bin/bash "$(HOME)/.oh-my-zsh/tools/uninstall.sh" || $(call print_error,"Failed to uninstall Oh My Zsh."); \
	else \
		$(call print_info,"Oh My Zsh is not installed."); \
	fi
	@$(MAKE) cleanup-symlinks || $(call print_error,"Failed to clean up some symlinks.")
	@$(call print_step,"Removing additional configuration directories...")
	-@rm -rf $(HOME)/.cache
	-@rm -rf $(HOME)/.config
	-@rm -rf $(HOME)/.local
	-@rm -rf $(HOME)/.npm
	-@rm -rf $(HOME)/.ssh
	-@rm -rf $(HOME)/.terminfo
	-@rm -rf $(HOME)/.tig_history
	-@rm -rf $(HOME)/.vim
	-@rm -rf $(HOME)/.viminfo
	-@rm -rf $(HOME)/.zcompdump-*
	-@rm -rf $(HOME)/.zsh_history
	-@rm -rf $(HOME)/.zsh_sessions
	-@rm -rf $(STATUS_DIR)
	@$(call print_bold,==> Uninstallation process complete.)

OH_MY_ZSH_INSTALL_SCRIPT := https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

ZSH_AUTOSUGGESTIONS_DIR := $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions
ZSH_AUTOSUGGESTIONS_REPO := https://github.com/zsh-users/zsh-autosuggestions

ZSH_SYNTAX_HIGHLIGHTING_DIR := $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGNTING_REPO := https://github.com/zsh-users/zsh-syntax-highlighting

install-oh-my-zsh:
	@$(call print_step,"Installing Oh My Zsh...")
	@if [ ! -d "$(HOME)/.oh-my-zsh" ]; then \
		/bin/bash -c "$$(curl -fsSL $(OH_MY_ZSH_INSTALL_SCRIPT))" "" --unattended && \
		$(call print_info,"Oh My Zsh core installed successfully.") || \
		{ $(call print_error,"Failed to install Oh My Zsh core."); exit 1; }; \
	else \
		$(call print_info,"Oh My Zsh is already installed."); \
	fi
	@$(call print_step,"Installing Zsh Autosuggestions...")
	@if [ ! -d "$(ZSH_AUTOSUGGESTIONS_DIR)" ]; then \
		git clone $(ZSH_AUTOSUGGESTIONS_REPO) $(ZSH_AUTOSUGGESTIONS_DIR) && \
		$(call print_info,"Zsh Autosuggestions installed successfully.") || \
		{ $(call print_error,"Failed to install Zsh Autosuggestions."); exit 1; }; \
	else \
		$(call print_info,"Zsh Autosuggestions already installed."); \
	fi
	@$(call print_step,"Installing Zsh Syntax Highlighting...")
	@if [ ! -d "$(ZSH_SYNTAX_HIGHLIGHTING_DIR)" ]; then \
		git clone $(ZSH_SYNTAX_HIGHLIGNTING_REPO) $(ZSH_SYNTAX_HIGHLIGHTING_DIR) && \
		$(call print_info,"Zsh Syntax Highlighting installed successfully.") || \
		{ $(call print_error,"Failed to install Zsh Syntax Highlighting."); exit 1; }; \
	else \
		$(call print_info,"Zsh Syntax Highlighting already installed."); \
	fi
	@touch $(OH_MY_ZSH_STATUS)
	@$(call print_bold,==> Oh My Zsh installation complete.) && $(SUCCESS_CMD)

HOMEBREW_INSTALL_SCRIPT := https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

install-homebrew:
	@$(call print_step,"Installing Homebrew...")
	@if ! command -v brew &> /dev/null; then \
		/bin/bash -c "$$(curl -fsSL $(HOMEBREW_INSTALL_SCRIPT))" && \
		$(call print_info,"Homebrew installed successfully.") || \
		{ $(call print_error,"Failed to install Homebrew."); exit 1; }; \
	else \
		$(call print_info,"Homebrew is already installed."); \
	fi
	@if command -v brew &> /dev/null; then \
		brew analytics off && \
		$(call print_info,"Homebrew analytics disabled.") || \
		$(call print_warning,"Failed to disable Homebrew analytics."); \
	fi
	@touch $(HOMEBREW_STATUS)
	@$(call print_bold,==> Homebrew installation complete.) && $(SUCCESS_CMD)

# Track package installation success/failure
PACKAGE_SUCCESS := 0
PACKAGE_FAILURES := 0

define install-brew-item
	@if ! brew list --$(1) "$(2)" &> /dev/null; then \
		$(call print_step,"Installing $(2)..."); \
		if brew install --$(1) "$(2)" &> /dev/null; then \
			$(call print_info,"Successfully installed $(2).") && $(SUCCESS_CMD); \
			PACKAGE_SUCCESS=$$((PACKAGE_SUCCESS+1)); \
		else \
			$(call print_error,"Failed to install $(2).") && $(FAIL_CMD); \
			PACKAGE_FAILURES=$$((PACKAGE_FAILURES+1)); \
		fi; \
	else \
		echo "$(2) is already installed."; \
		PACKAGE_SUCCESS=$$((PACKAGE_SUCCESS+1)); \
	fi
endef

install-homebrew-packages: install-homebrew
	@$(call print_step,"Installing Homebrew packages and casks...")
	@if [ ! -f $(HOMEBREW_STATUS) ]; then \
		$(call print_error,"Homebrew installation failed. Cannot install packages."); \
		exit 1; \
	fi
	@PACKAGE_SUCCESS=0; \
	PACKAGE_FAILURES=0; \
	$(foreach package,$(PACKAGES),$(call install-brew-item,formula,$(package));) \
	$(foreach cask,$(CASKS),$(call install-brew-item,cask,$(cask));) \
	$(call print_info,"Packages installed: $$PACKAGE_SUCCESS, Failed: $$PACKAGE_FAILURES"); \
	brew cleanup &> /dev/null || $(call print_warning,"Failed to clean up Homebrew cache."); \
	[ $$PACKAGE_FAILURES -eq 0 ] && touch $(HOMEBREW_PACKAGES_STATUS) || true
	@if [ -f $(HOMEBREW_PACKAGES_STATUS) ]; then \
		$(call print_bold,==> Homebrew packages and casks installation complete.) && $(SUCCESS_CMD); \
	else \
		$(call print_warning,"Some Homebrew packages failed to install."); \
	fi

TERMINFO_SUCCESS := 0
TERMINFO_FAILURES := 0

define compile-terminfo-file
	@if [ -f "$(PWD)/.terminfo/$(1)" ]; then \
		$(call print_step,"Compiling $(1)..."); \
		if tic -x "$(PWD)/.terminfo/$(1)" &> /dev/null; then \
			$(call print_info,"Successfully compiled $(1).") && $(SUCCESS_CMD); \
			TERMINFO_SUCCESS=$$((TERMINFO_SUCCESS+1)); \
		else \
			$(call print_error,"Failed to compile $(1).") && $(FAIL_CMD); \
			TERMINFO_FAILURES=$$((TERMINFO_FAILURES+1)); \
		fi; \
	else \
		$(call print_warning,"File not found: $(1)"); \
		TERMINFO_FAILURES=$$((TERMINFO_FAILURES+1)); \
	fi
endef

compile-terminfo: install-homebrew-packages
	@$(call print_step,"Compiling Terminfo files...")
	@if ! command -v tic &> /dev/null; then \
		$(call print_error,"The 'tic' command is not available. Terminfo compilation skipped."); \
		exit 1; \
	fi
	@TERMINFO_SUCCESS=0; \
	TERMINFO_FAILURES=0; \
	$(foreach terminfo_file,$(TERMINFO),$(call compile-terminfo-file,$(terminfo_file));) \
	$(call print_info,"Terminfo files compiled: $$TERMINFO_SUCCESS, Failed: $$TERMINFO_FAILURES"); \
	[ $$TERMINFO_FAILURES -eq 0 ] && touch $(TERMINFO_STATUS) || true
	@if [ -f $(TERMINFO_STATUS) ]; then \
		$(call print_bold,==> Finished compiling Terminfo files.) && $(SUCCESS_CMD); \
	else \
		$(call print_warning,"Some Terminfo files failed to compile."); \
	fi

TPM_DIR := $(HOME)/.config/tmux/plugins/tpm
TPM_REPO := https://github.com/tmux-plugins/tpm

install-tmux-plugin-manager: setup-symlinks
	@$(call print_step,"Installing Tmux Package Manager (TPM)...")
	@if [ ! -f $(SYMLINKS_STATUS) ]; then \
		$(call print_warning,"Symlinks setup failed. TPM installation might not work correctly."); \
	fi
	@mkdir -p $(HOME)/.config/tmux/plugins &> /dev/null || \
		{ $(call print_error,"Failed to create directory for TPM."); exit 1; }
	@if [ ! -d "$(TPM_DIR)" ]; then \
		git clone $(TPM_REPO) $(TPM_DIR) &> /dev/null && \
		$(call print_info,"TPM installed successfully.") && touch $(TPM_STATUS) || \
		{ $(call print_error,"Failed to clone TPM repository."); exit 1; }; \
	else \
		$(call print_info,"TPM is already installed.") && touch $(TPM_STATUS); \
	fi
	@$(call print_bold,==> TPM installation complete.) && $(SUCCESS_CMD)

SYMLINKS_SUCCESS := 0
SYMLINKS_FAILURES := 0

# Function to create a symbolic link
define create_link_with_checks
	@if [ -e "$(PWD)/$(1)" ]; then \
		$(call print_step,"Creating symlink for $(1)..."); \
		if [ -L "$(HOME)/$(1)" ]; then \
			echo "Removing existing symlink: $(HOME)/$(1)"; \
			unlink "$(HOME)/$(1)" &> /dev/null || \
				{ $(call print_error,"Failed to remove existing symlink."); SYMLINKS_FAILURES=$$((SYMLINKS_FAILURES+1)); return; }; \
		elif [ -e "$(HOME)/$(1)" ]; then \
			echo "Backing up existing file/directory: $(HOME)/$(1).bak"; \
			mv "$(HOME)/$(1)" "$(HOME)/$(1).bak" &> /dev/null || \
				{ $(call print_error,"Failed to backup existing file."); SYMLINKS_FAILURES=$$((SYMLINKS_FAILURES+1)); return; }; \
		fi; \
		mkdir -p "$$(dirname "$(HOME)/$(1)")" &> /dev/null || \
			{ $(call print_error,"Failed to create parent directory."); SYMLINKS_FAILURES=$$((SYMLINKS_FAILURES+1)); return; }; \
		if ln -fs "$(PWD)/$(1)" "$(HOME)/$(1)" &> /dev/null; then \
			echo "Created symlink for $(1)" && $(SUCCESS_CMD); \
			SYMLINKS_SUCCESS=$$((SYMLINKS_SUCCESS+1)); \
		else \
			$(call print_error,"Failed to create symlink.") && $(FAIL_CMD); \
			SYMLINKS_FAILURES=$$((SYMLINKS_FAILURES+1)); \
		fi; \
	else \
		$(call print_warning,"Source path does not exist: $(PWD)/$(1)"); \
		SYMLINKS_FAILURES=$$((SYMLINKS_FAILURES+1)); \
	fi
endef

setup-symlinks: compile-terminfo
	@$(call print_step,"Creating symbolic links...")
	@# Check if terminfo compilation succeeded
	@if [ ! -f $(TERMINFO_STATUS) ]; then \
		$(call print_warning,"Terminfo compilation failed. Proceeding with symlinks setup anyway."); \
	fi
	@# Ensure the .config directory exists
	@mkdir -p $(HOME)/.config &> /dev/null || \
		{ $(call print_error,"Failed to create .config directory."); exit 1; }
	@SYMLINKS_SUCCESS=0; \
	SYMLINKS_FAILURES=0; \
	$(foreach dotfile,$(DOTFILES),$(call create_link_with_checks,$(dotfile));) \
	$(foreach folder,$(CONFIG),$(call create_link_with_checks,.config/$(folder));) \
	$(call print_info,"Symlinks created: $$SYMLINKS_SUCCESS, Failed: $$SYMLINKS_FAILURES"); \
	[ $$SYMLINKS_FAILURES -eq 0 ] && touch $(SYMLINKS_STATUS) || true
	@if [ -f $(SYMLINKS_STATUS) ]; then \
		$(call print_bold,==> Finished creating symbolic links.) && $(SUCCESS_CMD); \
	else \
		$(call print_warning,"Some symlinks failed to create."); \
	fi

# Function to remove a symbolic link
define remove_link
	@if [ -L "$(1)" ]; then \
		$(call print_step,"Removing symlink $(1)..."); \
		if unlink "$(1)" &> /dev/null; then \
			echo "Removed $(1)" && $(SUCCESS_CMD); \
		else \
			$(call print_error,"Failed to remove $(1)") && $(FAIL_CMD); \
		fi; \
	else \
		echo "Symbolic link does not exist: $(1)"; \
	fi
endef

cleanup-symlinks:
	@$(call print_step,"Removing symbolic links...")
	@$(foreach dotfile,$(DOTFILES),$(call remove_link,$(HOME)/$(dotfile)))
	@$(foreach folder,$(CONFIG),$(call remove_link,$(HOME)/.config/$(folder)))
	@$(call print_bold,==> Finished removing symbolic links.)
