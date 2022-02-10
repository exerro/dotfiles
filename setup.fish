#!/usr/bin/env fish

sudo apt-get update

set -l script_path (dirname (status --current-filename))

function install_package
	if not sudo apt-get install -y $argv
		exit $status
	end
end

echo "Setting fish aliases"
rm ~/.config/fish/config.fish
rm -r ~/.config/fish/conf.d
rm -r ~/.config/fish/completions
rm -r ~/.config/fish/functions
ln -s (realpath $script_path/.config/fish/config.fish) ~/.config/fish/config.fish
ln -s (realpath $script_path/.config/fish/conf.d) ~/.config/fish/conf.d
ln -s (realpath $script_path/.config/fish/completions) ~/.config/fish/completions
ln -s (realpath $script_path/.config/fish/functions) ~/.config/fish/functions

if not type -q fortune
	echo "Installing fortune-mod"
	install_package fortune-mod
end

if not type -q cowsay
	echo "Installing cowsay"
	install_package cowsay
end

if not type -q highlight
	echo "Installing highlight"
	install_package highlight
end

if not test -e /usr/share/highlight/langDefs/fish.lang
	echo "Adding fish syntax highlighting to highlight"
	ln -s (realpath $script_path/config/fish.lang) /usr/share/highlight/langDefs/fish.lang
end

if not type -q exa
	echo "Installing exa"
	install_package libgit2-dev rustc
	sudo apt-mark auto rustc
	git clone https://github.com/ogham/exa --depth=1
	cd exa
	cargo build --release &&\
	sudo install -y target/release/exa /usr/local/bin/exa &&\
	cd .. &&\
	rm -rf exa &&\
	sudo apt purge --autoremove
end
