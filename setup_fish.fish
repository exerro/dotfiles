#!/usr/bin/env fish

sudo apt-get update

set -l script_path (dirname (status --current-filename))

function install_package
	sudo apt-get install -y $argv
end

echo "Setting fish aliases"
rm ~/.config/fish/config.fish
ln -s (realpath $script_path/config.fish) ~/.config/fish/config.fish
ln -s (realpath $script_path/conf.d) ~/.config/fish/conf.d
ln -s (realpath $script_path/completions) ~/.config/fish/completions
set -U fish_function_src_path (realpath $script_path/.config/fish/functions)

echo "Installing useful packages"
install_package fortune-mod
install_package cowsay
install_package highlight

if not type -q exa
	echo "Installing exa"
	install_package libgit2-dev rustc
	sudo apt-mark auto rustc
	git clone https://github.com/ogham/exa --depth=1
	cd exa
	cargo build --release && cargo test #cargo test is optional
	sudo install -y target/release/exa /usr/local/bin/exa
	cd ..
	rm -rf exa
	sudo apt purge --autoremove
else
	echo "exa already installed"
end
