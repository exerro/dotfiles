#!/usr/bin/env fish

function fish_title --description 'Set the terminal tab title'
	if set -q tab_title
		printf "$tab_title :: "
	end

	# echo (set -q argv[1] && echo $argv[1] || status current-command) (prompt_pwd)
	echo (prompt_pwd)
end
