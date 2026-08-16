{
	inputs,
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware-configuration-wiredg.nix
		inputs.nix-minecraft.nixosModules.minecraft-servers
	];

	nixpkgs.overlays = [
		inputs.nix-minecraft.overlay
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
		#ngrok
	];

	# Open ports in the firewall.
	#networking.firewall.allowedTCPPorts = [ ... ];
	#networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	#networking.firewall.enable = false;

	#networking.firewall.allowedTCPPorts = [ 3000 ]; # for local network "hosting"

	#services.nginx = {
	#	enable = true;
	#	virtualHosts.localhost = {
	#		locations."/" = {
	#			return = "200 '<html><body>It works</body></html>'";
	#			extraConfig = ''
	#				default_type text/html;
	#			'';
	#		};
	#	};
	#};

	networking.wg-quick.interfaces.wg0 = {
		autostart = false;
		configFile = "/home/myshko/.config/stuffs/wg0.conf";
	};

	# minecraft server using nixpkgs:
	#networking.firewall.allowedTCPPorts = [ 25565 ];
	#services = {
	#	minecraft-server = {
	#		enable = true;
	#		eula = true;
	#		# package = pkgs.minecraft-server-1_21_4;
	#		declarative = true;
	#		# jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
	#		# whitelist = {};
	#		openFirewall = true; # open firewall at port 25565.
	#		serverProperties = {
	#			allow-flight = true;
	#			difficulty = "hard";
	#			enable-command-block = true;
	#			gamemode = "survival";
	#			level-seed = "42";
	#			motd = "hell yeah";
	#			# simulation-distance = 10;
	#			pause-when-empty-seconds = 60 * 60;
	#			# "query.port" = 25565;
	#			# view-distance = 10;
	#		};
	#	};
	#};

	# minecraft server using nix-minecraft flake:
	networking.firewall.allowedTCPPorts = [ 25565 ]; # for java
	networking.firewall.allowedUDPPorts = [ 19132 ]; # for bedrock via geyser
	services = {
		minecraft-servers = {
			enable = true;
			eula = true;
			openFirewall = true;
			servers = {
				lambda_cc = {
					enable = true;
					autoStart = false;
					package = pkgs.fabricServers.fabric-26_2.override {
						loaderVersion = "0.19.3";
						jre_headless = pkgs.openjdk25_headless; # src: ?
					};
					jvmOpts = "-XX:+UseG1GC -Xms8G -Xmx16G -XX:MaxGCPauseMillis=200";
					serverProperties = {
						# src: https://minecraft.wiki/w/Server.properties
						white-list = true;
						allow-flight = true;
						difficulty = "hard";
						gamemode = "survival";
						level-seed = "643f77bf396efdd1";
						motd = "raising money to buy death stranding 2 for a friend"; # TODO?: rewrite
						pause-when-empty-seconds = 5 * 60;
						spawn-protection = 0;
						simulation-distance = 20;
						view-distance = 32;
						enable-command-block = true;
					};
					##whitelist = { ... };
					files = { # mutable files
						"ops.json".value = [
							{
								name = "miku__UwU";
								uuid = "54aaf78f-3981-4997-bd69-7b5025dacdcc";
								level = 4;
								bypassesPlayerLimit = true;
							}
							{
								name = ".mikuUwU3823";
								uuid = "00000000-0000-0000-0009-01f0370fa1eb";
								level = 4;
								bypassesPlayerLimit = true;
							}
						];
					};
					symlinks = {
						mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
							AntiXray = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/sml2FMaA/versions/AK313N9m/antixray-fabric-1.4.16%2B26.1.jar"; sha512 = "sha512-IT5l7gWEpmAhGPnm74Ydk/wJFgxbMrYn0pS5IKCNXPwlqDnyW/sqU73xreuNT9WMpnQ6PJk+h8+Ljis3G6Kp6w=="; };
							Geyser = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/SansJdt3/Geyser-Fabric-2.11.1-b1223.jar"; sha512 = "sha512-FKzkHgeWEfuBWttFzj7kCVC/IjjZWyevM6xqbmjVPcJjB2TxscEWiubgSSxcapyb8s2IuyuPqmccV3H0zw+G+g=="; };
							Floodgate = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/urOFTrVX/Floodgate-Fabric-2.2.6-b67.jar"; sha512 = "sha512-1uys+/HDEXExd5J4N1TE9YQUUIqP0aojuePaXan+RQpuboguOehiy18d840tl76EZaOYV/5LeMHPiZNCMKcSBQ=="; };
							# DistantHorizons = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uCdwusMi/versions/FJrLlu3p/DistantHorizons-3.0.3-b-26.1.2-fabric-neoforge.jar"; sha512 = "sha512-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"; };
							Terralith = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/OxfI2n80/Terralith_26.2_v2.6.4.jar"; sha512 = "sha512-CDD0YBZ0xOpY0kenG/3IIORnaQDhc8fW305Y40ignaQ7J5zqBg33tn5vdMhOKgW0AbLfeYNsN8/8jcmUhEqyUA=="; };
							Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/f7vZ0VWU/lithium-fabric-0.25.3%2Bmc26.2.jar"; sha512 = "sha512-FItjjzxiKfuvSHEgojRKCvXkEaWqZTPV25112gqMDYME9j60zKE/TQOyybTCPVWd10wdgyQi74owh70AXmKovQ=="; };
							C2ME = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/jSMMstCy/c2me-fabric-mc26.2-0.4.2-alpha.0.43.jar"; sha512 = "sha512-ycnJur5NlOBqv3LJLkU6qjnIJjSnrmRtEEH2c+Eu/z2Z534gWmhupT0KWuFD6eHm7VlbPM/K6v5ky/tjJ+LzdQ=="; };
							# FerriteCore = fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/d5ddUdiB/ferritecore-9.0.0-fabric.jar"; sha512 = "sha512-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"; };
							# Krypton = fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/5WeL0Nkz/krypton-0.3.1.jar"; sha512 = "sha512-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"; };
							# deps:
							Lithostitched = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/XaDC71GB/versions/V3XWhM8r/lithostitched-1.8.0%2Bbeta3-fabric-26.2.jar"; sha512 = "sha512-Mvm3R7gMm1rAHumOFnSR1OpDMVjCJGL4DjAfsyI4weAfXFXd7S+yDgdFcg3n84gZcfId/vA8E1wf7VqK+y6oow=="; }; # for Terralith
							FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/vmQp7ixA/fabric-api-0.157.0%2B26.2.jar"; sha512 = "sha512-Tr7EifKyzmIevrstG36XFLb9KI69tOKH12fN5XYSzx09HU9R2vfn7JVB+hRt9r3kl4q5iiljfO1tm8LzxCF2UA=="; }; # for Geyser & Floodgate
						});
					};
				};
			};
		};
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?
}
