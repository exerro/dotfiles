#!/usr/bin/env fish

function set_title --description 'Set the terminal tab title prefix'
	set -g tab_title $argv[1]
end
