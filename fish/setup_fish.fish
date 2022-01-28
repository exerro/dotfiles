#!/usr/bin/env fish

set -l script_path (dirname (status --current-filename))

function install_package
	sudo apt-get install $argv
end

echo "Aliasing functions"
rm -r ~/.config/fish/functions
ln -s (realpath $script_path/functions) ~/.config/fish/functions

echo "Setting `cls` alias"
abbr -a cls clear

echo "Aliasing config.fish"
rm ~/.config/fish/config.fish
ln -s (realpath $script_path/config.fish) ~/.config/fish/config.fish

echo "Setting colours"
set -U fish_color_quote ffa432
set -U fish_color_command yellow
set -U fish_color_cwd_root cyan
set -U fish_color_cwd cyan
set -U fish_color_user magenta
set -U CDPATH . ~/code/dev/app ~/code/dev/lib
set -U fish_function_src_path (realpath $script_path/functions)
set -U LS_COLORS "no=00:fi=36:di=33:ln=32:pi=01;30:do=01;30:bd=01;30:cd=01;30:or=31:so=01;30:su=01;30:sg=01;30:tw=01;30:ow=33:st=01;30:ex=36:mi=31"

echo "Setting up git stuff"
set -U __fish_git_prompt_show_informative_status 1
set -U __fish_git_prompt_hide_untrackedfiles 1
set -U __fish_git_prompt_color_branch green
set -U __fish_git_prompt_showupstream "informative"
set -U __fish_git_prompt_char_upstream_ahead "↑"
set -U __fish_git_prompt_char_upstream_behind "↓"
set -U __fish_git_prompt_char_upstream_prefix " "
set -U __fish_git_prompt_char_stagedstate "●"
set -U __fish_git_prompt_char_dirtystate "✚"
set -U __fish_git_prompt_char_untrackedfiles "…"
set -U __fish_git_prompt_char_conflictedstate "✖"
set -U __fish_git_prompt_char_cleanstate "✓"
set -U __fish_git_prompt_color_stagedstate yellow
set -U __fish_git_prompt_color_dirtystate blue
set -U __fish_git_prompt_color_invalidstate red
set -U __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -U __fish_git_prompt_color_cleanstate green

echo "Installing useful packages"
install_package fortune-mod
install_package cowsay
install_package highlight

echo "Setting up ssh to add automatically"
if test -z (cat ~/.ssh/config | grep "AddKeysToAgent yes")
	printf "\nAddKeysToAgent yes\n" >> ~/.ssh/config
end
