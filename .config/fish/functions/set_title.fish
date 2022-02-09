#!/usr/bin/env fish

function set_title --description 'Set the terminal tab title'
	set -g _tab_title (string join " " $argv)
end
