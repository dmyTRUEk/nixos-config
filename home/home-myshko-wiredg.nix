{
	inputs,
	lib,
	config,
	pkgs,
	pkgs_a85fc0a,
	...
}: {
	imports = [
		#inputs.plasma-manager.homeModules.plasma-manager # TODO(refactor): move to `kde-plasma-config-wiredg.nix`?
		#./kde-plasma-config-wiredg.nix # TODO?
	];

	programs = {};

	home.packages = with pkgs; [ # PKGS
		# pkgs_a85fc0a.mathematica # wolfram mathematica 14.1 # TODO
	];
}
