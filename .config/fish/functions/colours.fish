#!/usr/bin/env fish

function colours --description 'Show all the text and background colours'
	echo " normal      - bold        - italic      - dim         - br"

	for c in red yellow green cyan blue purple white black
		printf " "
		printf (set_color $c)
		printf "hello world"
		printf (set_color normal)
		printf " - "
		printf (set_color --bold $c)
		printf "hello world"
		printf (set_color normal)
		printf " - "
		printf (set_color --italic $c)
		printf "hello world"
		printf (set_color normal)
		printf " - "
		printf (set_color --dim $c)
		printf "hello world"
		printf (set_color normal)
		printf " - "
		printf (set_color br$c)
		printf "hello world"
		printf (set_color normal)
		printf "\n"
	end
end
