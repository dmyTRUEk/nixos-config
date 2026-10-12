{ pkgs, ... }: {
	imports = [
		./programs/wm.nix
	];

	programs = {};

	home.packages = with pkgs; [ # PKGS
	];
}
