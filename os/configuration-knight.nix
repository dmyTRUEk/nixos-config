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

	boot.loader.systemd-boot = {
		edk2-uefi-shell.enable = true;
		windows = {
			"10" = {
				efiDeviceHandle = "FS0";
				sortKey = "a_windows";
			};
		};
	};

	programs = {};

	environment.systemPackages = with pkgs; [ # PKGS
	];
}
