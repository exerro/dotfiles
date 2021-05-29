#!/usr/bin/env fish

function x_server
	set -g DISPLAY (grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
end

funcsave x_server
