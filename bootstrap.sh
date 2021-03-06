#!/usr/bin/env zsh

BREW_PACKAGES=(git mc htop iftop ifstat wget mtr wrk tree ranger ack ag cloc tmux tmux-mem-cpu-load reattach-to-user-namespace spark cmatrix figlet)

function install_brew_packages() {
    for index in $BREW_PACKAGES; do
        if command -v $index >/dev/null 2>&1; then
            echo "    > (Skipping) $index already installed."
        else
            echo "    > Installing $index..."
            brew install $index &> /dev/null
        fi
    done
}


echo "     _       _    __ _ _"
echo "  __| | ___ | |_ / _(_) | ___  ___"
echo " / _\` |/ _ \| __| |_| | |/ _ \/ __|"
echo "| (_| | (_) | |_|  _| | |  __/\__ \\"
echo " \__,_|\___/ \__|_| |_|_|\___||___/"
echo ""

echo "==> Here we go..."

cd "$(dirname "$0")"

echo "  > Updating homebrew..."
brew update &> /dev/null

echo "  > Installing homebrew packages..."
install_brew_packages

echo "  > Pulling latest dot-files..."
git pull &> /dev/null

echo "  > Sync dot-files..."
rsync --exclude ".git/" --exclude ".DS_Store" --exclude "Makefile" --exclude "bootstrap.sh" --exclude "README.rst" -av . ~ &> /dev/null


unset BREW_PACKAGES
unset install_brew_packages
source ~/.zshrc

echo "==> Done with setup."
