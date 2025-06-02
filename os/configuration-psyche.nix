{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware-configuration-psyche.nix
		# inputs.nix-minecraft.nixosModules.minecraft-servers
	];

	# nixpkgs.overlays = [
	# 	inputs.nix-minecraft.overlay
	# ];

	networking.hostName = "psyche";

	time.timeZone = "Europe/Kyiv";

	boot.loader.systemd-boot = {
		editor = false;
		# edk2-uefi-shell.enable = true;
		# windows = {
		# 	"10" = {
		# 		efiDeviceHandle = "FS0";
		# 		sortKey = "a_windows";
		# 	};
		# };
	};

	systemd.tmpfiles.rules = [
		# src: https://nixos.wiki/wiki/AMD_GPU#HIP
		"L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
	];

	services.ollama.acceleration = "rocm"; # or cuda

	programs = {
		light.enable = true; # TODO?: move to HM   # had to be installed in root?
	};

	environment.systemPackages = with pkgs; [ # PKGS
	];

	# networking.firewall.allowedTCPPorts = [ 3000 ]; # for local network "hosting"

	# minecraft server using nixpkgs:
	# networking.firewall.allowedTCPPorts = [ 25565 ];
	# services = {
	# 	minecraft-server = {
	# 		enable = true;
	# 		eula = true;
	# 		# package = pkgs.minecraft-server-1_21_4;
	# 		declarative = true;
	# 		# jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC";
	# 		# whitelist = {};
	# 		openFirewall = true; # open firewall at port 25565.
	# 		serverProperties = {
	# 			allow-flight = true;
	# 			difficulty = "hard";
	# 			enable-command-block = true;
	# 			gamemode = "survival";
	# 			level-seed = "42";
	# 			motd = "hell yeah";
	# 			# simulation-distance = 10;
	# 			pause-when-empty-seconds = 60 * 60;
	# 			# "query.port" = 25565;
	# 			# view-distance = 10;
	# 		};
	# 	};
	# };

	# minecraft server using nix-minecraft flake:
	# services = {
	# 	minecraft-servers = {
	# 		enable = true;
	# 		eula = true;
	# 		openFirewall = true;
	# 		servers = {
	# 			my-cool-server-1 = {
	# 				enable = true;
	# 				autoStart = false;
	# 				package = pkgs.vanillaServers.vanilla-1_21_4;
	# 				serverProperties = {
	# 					# server-port = 25565;
	# 					allow-flight = true;
	# 					difficulty = "hard";
	# 					enable-command-block = true;
	# 					gamemode = "survival";
	# 					level-seed = "42";
	# 					motd = "hell yeah";
	# 					pause-when-empty-seconds = 60 * 60;
	# 					# "query.port" = 25565;
	# 					# simulation-distance = 10;
	# 					# view-distance = 10;
	# 				};
	# 				files = { # mutable files
	# 					"ops.json".value = [{
	# 						name = "dmyTRUEk";
	# 						uuid = "54aaf78f-3981-4997-bd69-7b5025dacdcc";
	# 						level = 4;
	# 					}];
	# 				};
	# 			};
	# 		};
	# 	};
	# };
}
