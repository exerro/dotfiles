#!/usr/bin/env fish

function x_server --description 'Set up X server config stuff (WSL2)'
	set -gx DISPLAY (grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
end
