{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware-configuration-psyche.nix
	];

	networking.hostName = "psyche";

	time.timeZone = "Europe/Kyiv";

	programs = {
		light.enable = true; # TODO?: move to HM   # had to be installed in root?
	};

	environment.systemPackages = with pkgs; [ # PKGS
	];
}
