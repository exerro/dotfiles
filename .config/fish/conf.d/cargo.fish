
# add cargo stuff to path if we have it installed
if test -d ~/.cargo
	if not contains ~/.cargo/bin $PATH
		set -gx -a PATH ~/.cargo/bin
	end
end
