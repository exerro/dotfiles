
# all credit goes to https://github.com/ivakyb/fish_ssh_agent/
# starts the SSH agent or something - does magic to make SSH work :D

function __ssh_agent_is_started -d "check if ssh agent is already started"
	if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
		source $SSH_ENV > /dev/null
	end

	if test -z "$SSH_AGENT_PID"
		return 1
	end

	ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
	#pgrep ssh-agent
	return $status
end

function __ssh_agent_start -d "start a new ssh agent"
	ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
	chmod 600 $SSH_ENV
	source $SSH_ENV > /dev/null
	true  # suppress errors from setenv, i.e. set -gx
end

if test -d ~/.ssh
	if not test -e ~/.ssh/config
		printf "\nAddKeysToAgent yes\n" >> ~/.ssh/config
	else if test -z (cat ~/.ssh/config | grep "AddKeysToAgent yes")
		printf "\nAddKeysToAgent yes\n" >> ~/.ssh/config
	end

	if test -z "$SSH_ENV"
		set -gx SSH_ENV $HOME/.ssh/environment
	end

	if not __ssh_agent_is_started
		__ssh_agent_start
	end
end
