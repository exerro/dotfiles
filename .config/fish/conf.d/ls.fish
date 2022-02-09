
if type -q exa
	alias ls "echo "(set_color red)"ls deprecated, use one of [l, la, lt, ll, llt]"

	alias l   'exa --sort=type --classify -1'
	alias la  'exa --sort=type --classify -1 -a'
	alias lt  'exa --sort=type --classify --tree --level 3'
	alias ll  'exa --sort=type --classify --long --all --group --header --git --binary --extended --inode --blocks'
	alias llt 'exa --sort=type --classify --long --all --group --header --git --binary --extended --inode --blocks --tree --level 2'
end
