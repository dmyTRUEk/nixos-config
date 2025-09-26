{
	inputs,
	lib,
	config,
	pkgs,
	pkgs_a85fc0a,
	...
}: {
	programs = {};

	home.packages = with pkgs; [ # PKGS
		# "LIBS":
		#light # TODO(fix): grant access to "video" group?

		pkgs_a85fc0a.mathematica # wolfram mathematica 14.1
	];
}
