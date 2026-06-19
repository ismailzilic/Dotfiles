#!/usr/bin/env zsh
# Setup script

set -euo pipefail

DOTFILES="${HOME}/Dotfiles"

# Utility functions
GREEN='\033[032m'
BLUE='\033[034m'
YELLOW='\033[033m'
RED='\033[031m'
RESET='\033[0m'

ok()	  { echo -e "${GREEN}✔ ${1}${RESET}" }
info()	  { echo -e "${BLUE}> ${1}${RESET}" }
warning() { echo -e "${YELLOW}!! ${1}${RESET}"; }
error()   { echo -e "${RED}X ${1}${RESET}"; }

# Install missing packages
echo "==> Double-checking missing packages..."

. /etc/os-release

install_if_missing() {
	local pkg="${1}"

	if [[ ! $(command -v "${pkg}") ]]; then

		case "${ID}" in
			arch)	sudo pacman -S --noconfirm "${pkg}" ;;
			fedora) sudo dnf install -y "${pkg}" ;;
			*)	error "Unsupported distro: ${ID}"; return 1 ;;
		esac

		ok "${pkg} installed"
	else
		info "${pkg} already installed"
	fi
}

install_if_missing fzf
install_if_missing zoxide
install_if_missing stow

# Stow dotfiles
echo "==> Stowing zsh config..."
stow --dir="${DOTFILES}" --target="${HOME}" zsh
ok "Dotfiles stowed"

# End
echo ""
ok "Setup completed. Restart your shell."
