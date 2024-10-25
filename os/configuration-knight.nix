{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	system.stateVersion = "23.11";

	imports = [
		./hardware-configuration-knight.nix
	];

	nixpkgs = {
		overlays = [];
		config = {
			allowUnfree = true;
		};
	};

	#time.timeZone = "Europe/Kyiv";

	networking = {
		hostName = "knight";
		networkmanager.enable = true;
	};

	programs = {};

	environment.systemPackages = with pkgs; [ # PKGS
	];
}
