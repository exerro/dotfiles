#!/usr/bin/env fish

set -l script_path (dirname (status --current-filename))
set -l has_files (ls ~/.config/fish/functions)

if test -n "$has_files"
	echo "Removing existing functions"
	rm ~/.config/fish/functions/*.fish
end

for f in $script_path/functions/*.fish
	set -l filename (basename $f)
	echo "Aliasing function $f"
	ln -s (realpath $f) ~/.config/fish/functions/$filename
end

abbr -a cls clear

rm ~/.config/fish/config.fish
ln -s (realpath $script_path/config.fish) ~/.config/fish/config.fish

set -U fish_color_quote ffa432
set -U fish_color_command yellow
set -U CDPATH . ~/code/dev/app ~/code/dev/lib
set -U fish_function_src_path (realpath $script_path/functions)

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