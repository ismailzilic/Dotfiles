#!/bin/bash
# Script used to install missing dependencies on Arch Linux

set -euo pipefail

install_if_missing() {
	local pkg=${1}

	if [[ ! command -v "${pkg}" &>/dev/null ]]; then
		echo "Missing package ${pkg}. Installing..."
		sudo pacman -S --noconfirm "${pkg}"
		echo "${pkg} installed."
	fi
}

install_if_missing fzf
install_if_missing zoxide
install_if_missing stow
