{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware-configuration-knight.nix
	];

	networking.hostName = "knight";

	time.timeZone = "Europe/Kyiv";

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
