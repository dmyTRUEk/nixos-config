{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [];

	programs = {};

	home.packages = with pkgs; [ # PKGS
		# "LIBS":
		#light # TODO(fix): grant access to "video" group?
	];
}
