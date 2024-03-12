# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "23.11";

	# You can import other NixOS modules here
	imports = [
		# If you want to use modules from other flakes (such as nixos-hardware):
		# inputs.hardware.nixosModules.common-cpu-amd
		# inputs.hardware.nixosModules.common-ssd

		# You can also split up your configuration and import pieces of it here:
		# ./users.nix

		# Import your generated (nixos-generate-config) hardware configuration
		./hardware-configuration.nix
	];

	nixpkgs = {
		# You can add overlays here
		overlays = [
			# If you want to use overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#   hi = final.hello.overrideAttrs (oldAttrs: {
			#     patches = [ ./change-hello-to-hi.patch ];
			#   });
			# })
		];
		# Configure your nixpkgs instance
		config = {
			# Disable if you don't want unfree packages
			allowUnfree = true;
		};
	};

	# This will add each flake input as a registry
	# To make nix3 commands consistent with your flake
	#nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

	# This will additionally add your inputs to the system's legacy channels
	# Making legacy nix commands consistent as well, awesome!
	#nix.nixPath = ["/etc/nix/path"];
	#environment.etc =
	#  lib.mapAttrs'
	#  (name: value: {
	#    name = "nix/path/${name}";
	#    value.source = value.flake;
	#  })
	#  config.nix.registry;

	nix.settings = {
		# Enable flakes and new "nix" command
		experimental-features = [ "nix-command" "flakes" ];
		# Deduplicate and optimize nix store
		auto-optimise-store = true;
	};

	boot = {
		loader = {
			efi.canTouchEfiVariables = true;
			systemd-boot = {
				enable = true;
				memtest86.enable = true;
			};
		};
		kernelPackages = pkgs.linuxPackages_latest;
		extraModulePackages = with config.boot.kernelPackages; [
			v4l2loopback # for obs virtual camera
		];
	};

	time.timeZone = "Europe/Kyiv";

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LC_ADDRESS        = "uk_UA.UTF-8";
			LC_INDETIFICATION = "uk_UA.UTF-8";
			LC_MEASUREMENT    = "uk_UA.UTF-8";
			LC_MONETARY       = "uk_UA.UTF-8";
			LC_NAME           = "uk_UA.UTF-8";
			LC_NUMERIC        = "uk_UA.UTF-8";
			LC_PAPER          = "uk_UA.UTF-8";
			LC_TELEPHONE      = "uk_UA.UTF-8";
			LC_TIME           = "en_US.UTF-8";
		};
	};

	networking = {
		hostName = "psyche"; # TODO: MOVE SOMEWHERE?? (to be cross pc compatible)
		networkmanager.enable = true;
	};

	systemd.extraConfig = ''
		DefaultTimeoutStopSec=10s
	'';

	services.xserver = {
		enable = true; # TODO: dont enable or why i need it?
		xkb = {
			layout = "us";
			options = "caps:swapescape,ctrl:swap_lalt_lctrl";
		};
		displayManager = {
			defaultSession = "sway";
			sddm = {
				enable = true;
				wayland.enable = true;
				theme = "chili";
			};
			#gdm = {
			#	enable = true;
			#	#wayland = false;
			#};
		};
		#desktopManager.xfce.enable = true;
	};

	users = {
		defaultUserShell = pkgs.fish;
		users = {
			myshko = {
				#initialPassword = "12";
				isNormalUser = true;
				description = "myshko";
				# TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
				extraGroups = [
					"wheel"          # for sudo
					"networkmanager" # for network
					"video"          # for brightness/light
					#"libvirtd"      # for virtualisation/VMs/gnome-boxes
				];
				packages = with pkgs; [
					# move `sway` here?
				];
			};
		};
	};

	programs = {
		neovim = {
			enable = true;
			defaultEditor = true;
		};

		fish.enable = true;

		git = {
			enable = true;
			config.init.defaultBranch = "main";
		};

		sway.enable = true;

		#waybar.enable = true;

		#firefox = {
		#  enable = true;
		#  preferences = { # TODO: move to HM
		#    "browser.tabs.inTitlebar" = 0;
		#  };
		#};

		light.enable = true; # TODO?: move to HM
	};

	environment.systemPackages = with pkgs; [
		# vim -> neovim
		# fish
		# git
		#wget curl
		dua

		sddm-chili-theme

		home-manager
		# everything else goes to home-manager (HM)
	];

	# TODO(refactor): move to HM?
	# rtkit is optional but recommended
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;
	};

	security.polkit.enable = true;

	#virtualisation.libvirtd = {
	#	enable = true;
	#	#qemu = {
	#	#	package = pkgs.qemu_kvm;
	#	#	runAsRoot = true;
	#	#	swtpm.enable = true;
	#	#	ovmf = {
	#	#		enable = true;
	#	#		packages = [(pkgs.unstable.OVMF.override {
	#	#			secureBoot = true;
	#	#			tpmSupport = true;
	#	#		}).fd];
	#	#	};
	#	#};
	#};

	# Enabling realtime may improve latency and reduce stuttering, specially in high load scenarios.
	# Enabling this option allows any program run by the "users" group to request real-time priority.
	#security.pam.loginLimits = [
	#	{ domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
	#];
}
