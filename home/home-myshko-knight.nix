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
		pkgs_a85fc0a.mathematica # wolfram mathematica 14.1
	];
}
