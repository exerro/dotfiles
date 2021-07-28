#!/usr/bin/env fish

function fish_right_prompt --description 'Write the prompt on the right of the terminal'
    printf "\u001b[36m"
	date "+%D %a %X"
	printf "\u001b[0m"
end
