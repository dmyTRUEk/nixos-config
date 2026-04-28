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
		#edk2-uefi-shell.enable = true;
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

	#services.ollama.acceleration = "rocm"; # or cuda

	programs = {};

	environment.systemPackages = with pkgs; [ # PKGS
	];

	environment.variables = {
		ROC_ENABLE_PRE_VEGA = "1";
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "24.11"; # Did you read the comment?
}
