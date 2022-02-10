#!/usr/bin/env fish

function fish_prompt --description 'Write the prompt'
	# the last pipe status
	set -l last_status $status

	# keep track of the length of the prompt
	set -l length 0

	# build up the right prompt text
	set -l right_prompt_text ""

	# work out what the prompt text should show
	set -l prompt_text_path ""
	set -l prompt_text_name (pwd \
		| sed "s@^$HOME/@~/@" \
		| sed "s@^$HOME\$@~@")

	# split the cwd into the path/name components
	if string match -q -- "*/*" "$prompt_text_name"
		set prompt_text_path (dirname $prompt_text_name)/
		set prompt_text_name (basename $prompt_text_name)
	end

	# show the prompt start
	printf (set_color normal)'╭─ '
	set length (math $length + 3)

	# show the user if on ssh or if we're root, and host if on ssh
	if set -q SSH_TTY
		# if we're running over ssh, purple username shown
		printf (set_color purple)$USER(set_color purple --dim)'@'$hostname' '(set_color normal)
		set length (math $length + (string length $USER'@'$hostname' '))
	else if functions -q fish_is_root_user; and fish_is_root_user
		# if we're root, red username shown
		printf (set_color red)$USER' '
		set length (math $length + (string length $USER' '))
	end

	# show the working directory
	printf (set_color cyan)$prompt_text_path(set_color cyan --bold)$prompt_text_name
	set length (math $length + (string length $prompt_text_path) + (string length $prompt_text_name))
	printf (set_color normal)

	# show git status
	if git rev-parse --is-inside-work-tree &> /dev/null
		# set -l git_text (fish_vcs_prompt | sed 's@(@@' | sed 's@)$@@')
		set -l git_branch (git rev-parse --abbrev-ref HEAD)
		printf (set_color yellow)" on  "
		printf (set_color green)$git_branch
		set length (math $length + 6 + (string length $git_branch))

		# TODO: cool characters for printing state ✓…•+-↑↓⬢❮▶
	end

	# add status to the right prompt text
	if string match --quiet --invert 0 $last_status # if the last command failed
		if test $last_status = 1 # if a simple failure
			set right_prompt_text $right_prompt_text(set_color red --bold)'☓ ' # print a bold green tick
			set length (math $length + 2)
		else
			set -l status_text (fish_status_to_signal $last_status)
			set right_prompt_text $right_prompt_text(set_color red --bold)'['$status_text'] ☓ ' # print a bold green tick
			set length (math $length + 5 + (string length $status_text))
		end
	else
		set right_prompt_text $right_prompt_text(set_color green --bold)'✓ ' # print a bold green tick
		set length (math $length + 2)
	end

	# add time to the right prompt text
	set -l time_text (date "+%X")
	set right_prompt_text $right_prompt_text(set_color normal)(set_color white --dim)$time_text
	set length (math $length + (string length $time_text))

	# dots!
	printf (set_color normal)(set_color white --dim)' '(string repeat -n (math (tput cols) - $length - 2) \u00b7)' '

	# right prompt
	printf (set_color normal)$right_prompt_text

	# show the next line
	printf (set_color normal)'\n╰─ '
end
