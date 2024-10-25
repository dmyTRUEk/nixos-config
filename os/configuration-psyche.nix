{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	system.stateVersion = "23.11";

	imports = [
		./hardware-configuration-psyche.nix
	];

	nixpkgs = {
		overlays = [];
		config = {
			allowUnfree = true;
		};
	};

	#time.timeZone = "Europe/Kyiv";

	networking = {
		hostName = "psyche";
		networkmanager.enable = true;
	};

	programs = {
		light.enable = true; # TODO?: move to HM   # had to be installed in root?
	};

	environment.systemPackages = with pkgs; [ # PKGS
	];
}
