{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	home = {
		# TODO: refactor to not write username manually?
		username = "guest";
		# homeDirectory = "/home/guest";
	};
}
