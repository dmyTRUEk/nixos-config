{
	inputs,
	lib,
	config,
	pkgs,
	pkgs_a85fc0a,
	...
}: {
	imports = [
		#inputs.plasma-manager.homeModules.plasma-manager # TODO(refactor): move to `kde-plasma-config-psyche.nix`?
		#./kde-plasma-config-psyche.nix # TODO?
	];

	programs = {};

	home.packages = with pkgs; [ # PKGS
		pkgs_a85fc0a.mathematica # wolfram mathematica 14.1
	];
}
