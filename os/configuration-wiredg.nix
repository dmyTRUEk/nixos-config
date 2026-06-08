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
				lambda_26_1_2 = {
					enable = true;
					autoStart = false;
					package = pkgs.fabricServers.fabric-26_1_2.override {
						jre_headless = pkgs.temurin-jre-bin-25;
					};
					jvmOpts = "-XX:+UseG1GC -Xms8G -Xmx16G -XX:MaxGCPauseMillis=200";
					serverProperties = {
						# src: https://minecraft.wiki/w/Server.properties
						white-list = true;
						allow-flight = true;
						difficulty = "hard";
						gamemode = "survival";
						level-seed = "643f77bf396efdd1";
						motd = "raising money to buy death stranding 2 for the admin friend"; # TODO?: rewrite
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
							Geyser = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/YxMEEm35/Geyser-Fabric-2.10.0-b1162.jar"; sha512 = "sha512-DqgFssVa6gI2oeqVIOKV7tfZltJ2UCNWZzaj2ehR13vbmMaOfkMdtWmguixtluddmLnzmo1co1TdRwNXq85tnw=="; };
							Floodgate = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/fD4J9lnX/Floodgate-Fabric-2.2.6-b63.jar"; sha512 = "sha512-VIdAMyNt9ojaFf1N19LZnQAuiVXLLXiNW6QJ11PrF2KfU6bpdpkt6MyoyN02Y8cLKD2oi1oS1yzvlkfQngSuYg=="; };
							# DistantHorizons = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/uCdwusMi/versions/FJrLlu3p/DistantHorizons-3.0.3-b-26.1.2-fabric-neoforge.jar"; sha512 = "sha512-EbJS3jMI1ymdNGJazmUiPZxdQuUqNAu5yF+gJQwMNUrVlLcvCoJ9nXwEa5XdF6XlAPk5VPFNA9qf2sdZbEG1FA=="; };
							Terralith = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/FCzSjHeG/Terralith_26.1_v2.6.2_Fabric.jar"; sha512 = "sha512-WjvimGpiREbIKoh5405Mewn2+YoZN/1Nm89TVrgyHwuc67XlZ+jQCugWHSYbEI+3yagOvtYfLtuM2whSszy6zA=="; };
							Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/GiCfpS6V/lithium-fabric-0.24.5%2Bmc26.1.2.jar"; sha512 = "sha512-XDG9NS2QTXa+O5fSPS1IWAx/kRbHP9PkNdtaeAFi4iniPyx+mH7jfX9lymZs9/gSFiYnvS6RbssJ2VgD9YKtNw=="; };
							# C2ME = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/MmyZoUyp/c2me-fabric-mc26.1.2-0.4.0-alpha.0.4.jar"; sha512 = "sha512-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"; };
							AntiXray = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/sml2FMaA/versions/AK313N9m/antixray-fabric-1.4.16%2B26.1.jar"; sha512 = "sha512-IT5l7gWEpmAhGPnm74Ydk/wJFgxbMrYn0pS5IKCNXPwlqDnyW/sqU73xreuNT9WMpnQ6PJk+h8+Ljis3G6Kp6w=="; };
							# FerriteCore = fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/ULSumfl4/ferritecore-6.0.0-forge.jar"; sha512 = "e78ddd02cca0a4553eb135dbb3ec6cbc59200dd23febf3491d112c47a0b7e9fe2b97f97a3d43bb44d69f1a10aad01143dcd84dc575dfa5a9eaa315a3ec182b37"; };
							# Krypton = fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/jiDwS0W1/krypton-0.2.3.jar"; sha512 = "92b73a70737cfc1daebca211bd1525de7684b554be392714ee29cbd558f2a27a8bdda22accbe9176d6e531d74f9bf77798c28c3e8559c970f607422b6038bc9e"; };
							# LazyDFU = fetchurl { url = "https://cdn.modrinth.com/data/hvFnDODi/versions/0.1.3/lazydfu-0.1.3.jar"; sha512 = "dc3766352c645f6da92b13000dffa80584ee58093c925c2154eb3c125a2b2f9a3af298202e2658b039c6ee41e81ca9a2e9d4b942561f7085239dd4421e0cce0a"; };
							# deps:
							Lithostitched = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/XaDC71GB/versions/BpryyUmm/lithostitched-1.7.9-fabric-26.1.jar"; sha512 = "sha512-7QtnKRG+aUn+obUAu683yBfTHgfz4jnR6NEsaHW1LrUeMKi/Z4xIvmNt0qe02ReULX1sm1M7Y1YlfPm/RlBT+w=="; }; # for Terralith
							FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/E1mjhYMF/fabric-api-0.150.0%2B26.1.2.jar"; sha512 = "sha512-I4x5O3IO0h0tW1ZOyojHFM8hiPew+x/TCGRmD4CQHitNrSc5lLb3fePAqjZfkw7Yqsz/rEmzbGRWsVO1LV0h3A=="; }; # for Geyser & Floodgate
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
