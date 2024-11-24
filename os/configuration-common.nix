{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		# If you want to use modules from other flakes (such as nixos-hardware):
		# inputs.hardware.nixosModules.common-cpu-amd
		# inputs.hardware.nixosModules.common-ssd

		# You can also split up your configuration and import pieces of it here:
		# ./users.nix

		# Import your generated (nixos-generate-config) hardware configuration
		#./hardware-configuration.nix
	];

	nixpkgs = {
		config.allowUnfree = true;
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

	nix = {
		gc.automatic = false;
		settings = {
			# Enable flakes and new "nix" command
			experimental-features = [ "nix-command" "flakes" ];
			# Deduplicate and optimize nix store
			auto-optimise-store = true;
		};
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

	networking = {
		#hostName = "noname"; # specified in `-knight` & `-psyche`
		networkmanager.enable = true;
	};

	hardware.bluetooth.enable = true; # enables support for Bluetooth
	#hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
	#hardware.opengl.extraPackages = with pkgs; [
	#	amdvlk # fix? for bevy
	#];

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

	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
		extraConfig = ''
			DefaultTimeoutStopSec=10s
		'';
	};

	services = {
		displayManager = {
			defaultSession = "sway";
			#sddm = {
			#	enable = true;
			#	wayland.enable = true;
			#	theme = "chili";
			#};
		};
		desktopManager = {
			plasma6.enable = true;
		};
		xserver = {
			enable = true; # TODO: dont enable or why i need it?
			videoDrivers = ["amdgpu"];
			xkb = {
				layout = "us";
				options = "caps:swapescape,ctrl:swap_lalt_lctrl";
			};
			displayManager = {
				gdm = {
					enable = true;
					wayland = true;
					#banner = "Greetings, human.";
					#hiddenUsers = [];
				};
			};
			#desktopManager.xfce.enable = true;
		};
		blueman.enable = true;
	};

	users = {
		defaultUserShell = pkgs.fish;
		users = {
			myshko = {
				#initialPassword = "12";
				isNormalUser = true;
				description = "myshko";
				extraGroups = [
					"wheel"          # for sudo
					"networkmanager" # for network
					"video"          # for brightness/light
					"libvirtd"       # for virtualisation/VMs/gnome-boxes
					"docker"         # for docker (yeah, i know)
					# "audio" ?
				];
				packages = with pkgs; [
					# TODO: move `sway` here?
				];
			};
			guest = {
				initialPassword = "1234";
				isNormalUser = true;
				description = "guest";
				extraGroups = [
					# "wheel"          # for sudo
					"networkmanager" # for network
					"video"          # for brightness/light
					# "libvirtd"       # for virtualisation/VMs/gnome-boxes
					# "docker"         # for docker (yeah, i know)
					# "audio" ?
				];
				packages = with pkgs; [];
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

		# sadly, it have to be installed in root to work
		steam = { # the meme
			enable = true;
			remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
			#gamescopeSession.enable = true; # if some games' scaling is wrong in some DE/WMs # usage: in steam launch options add `gamescope %command%`
		};
		#gamemode.enable = true; # game mode, to give max performance to the game # usage: in steam launch options add `gamemoderun %command%`
		#environment.systemPackages += mangohud # for mangohud (can be added in home.nix): fps, cpu%, gpu%, ram, vram, frame time, ... # usage: in steam launch options add `mangohud %command%`

		nh = { # (rust btw)
			enable = true;
			flake = "/home/myshko/.config/home-manager";
		};
	};

	environment.systemPackages = with pkgs; [ # PKGS
		vim # -> neovim
		#wget
		#curl

		#sddm-chili-theme

		home-manager
		# everything else goes to home-manager (HM)
	];

	services.pipewire = {
		enable = true;
		pulse.enable = true;
		alsa = {
			enable = true;
			support32Bit = true;
		};
		# If you want to use JACK applications, uncomment this
		#jack.enable = true;
	};

	security = {
		# TODO(refactor): move to HM?
		# rtkit is optional but recommended
		rtkit.enable = true;
		polkit.enable = true;
	};

	virtualisation = {
		docker.enable = true;
		libvirtd = {
			enable = true;
			#qemu = {
			#	package = pkgs.qemu_kvm;
			#	runAsRoot = true;
			#	swtpm.enable = true;
			#	ovmf = {
			#		enable = true;
			#		packages = [(pkgs.unstable.OVMF.override {
			#			secureBoot = true;
			#			tpmSupport = true;
			#		}).fd];
			#	};
			#};
		};
	};

	# Enabling realtime may improve latency and reduce stuttering, specially in high load scenarios.
	# Enabling this option allows any program run by the "users" group to request real-time priority.
	#security.pam.loginLimits = [
	#	{ domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
	#];

	xdg = {
		portal = {
			enable = true;
			wlr.enable = true;
			#xdgOpenUsePortal = true;
			configPackages = [
				pkgs.sway
			];
			# TODO: enable?
			config = {
				sway = {
					default = [ "gtk" ];
					"org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
				};
				common.default = [ "gtk" ];
			};
			extraPortals = [ # deprecated?
				pkgs.xdg-desktop-portal-gtk
			];
		};
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "23.11"; # Did you read the comment?
}
