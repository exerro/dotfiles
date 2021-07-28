#!/usr/bin/env fish

function fish_greeting --description 'Display a welcome message to new terminals'
	if type -q fortune
		printf " "
		fortune
	else
		echo "(install fortune-mod for a fancy message here!)"
	end
end
