#!/usr/bin/env fish

function fish_greeting --description 'Display a welcome message to new terminals'
	fortune | cowsay
end
