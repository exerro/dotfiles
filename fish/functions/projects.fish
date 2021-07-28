#!/usr/bin/env fish

function projects --description "Navigate to dir containing projects"
	cd ~/code/projects
	ls | sort
end
