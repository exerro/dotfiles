#!/usr/bin/env fish

function project --description "Create a new project in ~/code/projects"
	set -l project_name $argv[1]

	if test $argv[2] = "win"
		if ! set -q windows_username
			printf "\u001b[31mNo Windows username set!\n\u001b[0m"
			printf "Use `set -U windows_username <username>`\n"
			return
		end

		set -l win_path /mnt/c/Users/$windows_username/code/projects/$project_name

		if ! test -d $win_path
			mkdir -p $win_path
		end

		ln -s $win_path ~/code/projects/$project_name
		cd ~/code/projects/$project_name
	else
		if ! test -d ~/code/projects/$project_name
			mkdir -p ~/code/projects/$project_name
		end

		cd ~/code/projects/$project_name
	end
end
