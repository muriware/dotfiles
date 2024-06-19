# Dotfiles

My personal dotfiles for setting up and customizing my environment.

### Install

Clone the repo and run:

```zsh
cd dotfiles && make install
```

### Uninstall

To remove the configurations:

```zsh
make uninstall
```

### Final Setup Steps after Installation

1. **Install Alfred**:

   - Visit the [Alfred Help and Support page](https://www.alfredapp.com/help/v4/).
   - Download and install Alfred 4.
   - Add license code.

2. **Install Font**:

   - Download [Source Code Pro Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro) from GitHub.
   - Add it to Font Book.

3. **iTerm Setup**:

   - Open iTerm.
   - Load preferences from dotfiles folder.

4. **Restart iTerm**:

   - Close and reopen iTerm.

5. **Tmux Plugins**:

   - In tmux, press `prefix` + `I`.

6. **SSH Config**:
   - Set up SSH as needed.
