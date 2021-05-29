#!/usr/bin/env fish

function sshs -d "start a new ssh agent and ssh-add"
	eval (ssh-agent -c) > /dev/null
	ssh-add
end
