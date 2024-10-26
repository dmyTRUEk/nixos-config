{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	home.stateVersion = "23.11";

	imports = [
		inputs.nix-colors.homeManagerModules.default
	];

	nixpkgs = {
		overlays = [];
		config = {
			allowUnfree = true;
			allowUnfreePredicate = _: true;
		};
	};

	programs = {};

	home.packages = with pkgs; [ # PKGS
		# "LIBS":
		#light # TODO(fix): grant access to "video" group?
	];
}
