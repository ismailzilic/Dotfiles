# Dotfiles

These configuration files are managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## Setup

As mentioned, you need GNU Stow installed on you system, or alternatively you can copy all the files manually.

1. **Clone the repository**:

    ```bash
    git clone https://github.com/ismailzilic/dotfiles.git ~/dotfiles

    cd ~/dotfiles
    ```

2. **Deploy dotfiles**:  
   From inside the `dotfiles` directory, run:

    ```bash
    stow zsh -t ~/
    stow .config -t ~/.config
    ```

    This will create symlinks in your home directory:

    `~/.zshrc` → `~/dotfiles/zsh/.zshrc`  
    `~/.config/...` → `~/dotfiles/.config/...`
