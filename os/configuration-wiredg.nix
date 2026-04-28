{
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware-configuration-wiredg.nix
	];

	networking.hostName = "wiredg";
	#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	time.timeZone = "Europe/Kyiv";

	boot.loader.systemd-boot = {
		editor = false;
		#edk2-uefi-shell.enable = true;
	};

	# Enable sound with pipewire.
	services.pulseaudio.enable = false;

	# Enable touchpad support (enabled default in most desktopManager).
	#services.xserver.libinput.enable = true;

	# Enable the OpenSSH daemon.
	#services.openssh.enable = true;

	#services.ollama.acceleration = "rocm"; # or cuda

	# Some programs need SUID wrappers, can be configured further or are started in user sessions.
	#programs.mtr.enable = true;
	#programs.gnupg.agent = {
	#	enable = true;
	#	enableSSHSupport = true;
	#};

	environment.systemPackages = with pkgs; [ # PKGS
	];

	# Open ports in the firewall.
	#networking.firewall.allowedTCPPorts = [ ... ];
	#networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	#networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?
}
