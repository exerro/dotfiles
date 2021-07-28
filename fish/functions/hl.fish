#!/usr/bin/env fish

function hl --description 'Syntax-highlight some text'
	highlight -O xterm256 --style=github $argv
end
