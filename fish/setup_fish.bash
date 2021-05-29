#!/usr/bin/env bash

echo "Installing fish"
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish

echo "Setting fish as default shell"
# echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s "/usr/bin/fish"

echo "Running fish-side setup"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
fish $SCRIPT_DIR/setup_fish.fish
