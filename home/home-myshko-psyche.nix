{
	inputs,
	lib,
	config,
	pkgs,
	pkgs_for_wm,
	...
}: {
	programs = {};

	home.packages = with pkgs; [ # PKGS
		pkgs_for_wm.mathematica # wolfram mathematica 14.1
	];
}
