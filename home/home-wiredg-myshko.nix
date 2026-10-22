{ pkgs, ... }: {
	imports = [
		./programs/wm.nix
	];

	home = {
		# TODO?: refactor to not write username manually
		username = "m";
		homeDirectory = "/home/m";  # remove bc not needed?
	};

	programs = {};

	home.packages = with pkgs; [ # PKGS
	];
}
