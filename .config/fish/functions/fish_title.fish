#!/usr/bin/env fish

function fish_title --description 'Set the terminal tab title'
	if set -q _tab_title
		printf $_tab_title
	else
		prompt_pwd
	end
end
