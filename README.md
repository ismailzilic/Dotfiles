# Dotfiles

These configuration files are managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## Setup

As mentioned, you need GNU Stow installed on you system, or alternatively you can copy all the files manually.

1. **Clone the repository**:

    ```bash
    git clone https://github.com/ismailzilic/Dotfiles.git ~/Dotfiles

    cd ~/Dotfiles
    ```

2. **Deploy dotfiles**:  
   Run in the `Dotfiles` directory:

    ```bash
    stow zsh -t ~
    stow .config -t ~/.config
    ```

    This will create symlinks in your home directory:

    `~/.zshrc` → `~/Dotfiles/zsh/.zshrc`  
    `~/.config/...` → `~/Dotfiles/.config/...`
