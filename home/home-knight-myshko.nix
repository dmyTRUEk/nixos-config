{ pkgs, ... }: {
	imports = [
		./programs/wm.nix
	];

	home = {
		# TODO?: refactor to not write username manually
		username = "myshko";
		homeDirectory = "/home/myshko";  # remove bc not needed?
	};

	programs = {};

	home.packages = with pkgs; [ # PKGS
	];
}
