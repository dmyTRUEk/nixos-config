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
		editor = false;
		# edk2-uefi-shell.enable = true;
		windows = {
			"10" = {
				efiDeviceHandle = "FS0";
				sortKey = "a_windows";
			};
		};
	};

	systemd.tmpfiles.rules = [
		# src: https://nixos.wiki/wiki/AMD_GPU#HIP
		"L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
	];

	services.ollama.acceleration = "rocm"; # or cuda

	programs = {};

	environment.systemPackages = with pkgs; [ # PKGS
	];

	environment.variables = {
		ROC_ENABLE_PRE_VEGA = "1";
	};
}
