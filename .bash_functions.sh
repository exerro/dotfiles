#!/usr/bin/env bash

function reload {
	source ~/.bashrc
}

function title {
   echo -ne "\033]0;$*\007"
   export T_TITLE="$*"
}

function git-changes {
	local pre="$(pwd)"

	for p in $*; do
		[ ! -d "$pre/$p" ] && continue

		cd "$pre/$p"

		if [ ! -d .git ]; then
			printf "\e[31m$p\e[37m: Not a git repo\e[0m\n"
			continue
		fi

		local diff=$(for br in $(git branch --list | sed -e 's/^\* \(.*\)/\1/'); do
			local existed_in_remote=$(git branch -a --list "origin/$br")

			if [[ -z $existed_in_remote ]]; then
				echo "No origin/$br"
				break
			fi

			local diff=$(git log -1 --pretty=format:"%H" "origin/$br..$br")

			if [[ ! -z "$diff" ]]; then
				echo "$diff not pushed ($br)"
				break
			fi

			git update-index -q --refresh

			local status="$(git status --porcelain)"

			if [[ "$status" ]]; then
				echo "Local changes"
				break
			fi
		done)

		if [[ ! -z "$diff" ]]; then
			printf "\e[33m$p\e[37m: $diff\n"
		else
			printf "\e[34m$p\e[37m: No changes\e[0m\n"
		fi
	done

	cd "$pre"
}
