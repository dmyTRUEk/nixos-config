{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware-configuration-psyche.nix
		#inputs.nix-minecraft.nixosModules.minecraft-servers
	];

	#nixpkgs.overlays = [
	#	inputs.nix-minecraft.overlay
	#];

	networking.hostName = "psyche";

	time.timeZone = "Europe/Kyiv";

	boot.loader.systemd-boot = {
		editor = false;
		#edk2-uefi-shell.enable = true;
		#windows = {
		#	"10" = {
		#		efiDeviceHandle = "FS0";
		#		sortKey = "a_windows";
		#	};
		#};
	};

	systemd.tmpfiles.rules = [
		# src: https://nixos.wiki/wiki/AMD_GPU#HIP
		"L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
	];

	#services.ollama.acceleration = "rocm"; # or cuda

	programs = {
	};

	environment.systemPackages = with pkgs; [ # PKGS
	];

	# networking.firewall.allowedTCPPorts = [ 3000 ]; # for local network "hosting"

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
	# networking.firewall.allowedTCPPorts = [ 25565 ];
	# networking.firewall.allowedUDPPorts = [ 19132 ]; # for bedrock via geyser
	# services = {
	# 	minecraft-servers = {
	# 		enable = true;
	# 		eula = true;
	# 		openFirewall = true;
	# 		servers = {
	# 			test-server-3 = {
	# 				enable = true;
	# 				autoStart = false;
	# 				package = pkgs.fabricServers.fabric-1_21_11;
	# 				serverProperties = {
	# 					# src: https://minecraft.wiki/w/Server.properties
	# 					# server-port = 25565;
	# 					# "query.port" = 25565;
	# 					# "rcon.port" = 25565;
	# 					allow-flight = true;
	# 					difficulty = "hard";
	# 					enable-command-block = true;
	# 					gamemode = "survival";
	# 					level-seed = "42";
	# 					motd = "stay silly~ :3";
	# 					pause-when-empty-seconds = 5 * 60;
	# 					simulation-distance = 10;
	# 					view-distance = 10; # TODO: increase
	# 					# jvmOpts = "-Xms6144M -Xmx8192M"; # TODO
	# 				};
	# 				files = { # mutable files
	# 					"ops.json".value = [{
	# 						name = "dmyTRUEk";
	# 						uuid = "54aaf78f-3981-4997-bd69-7b5025dacdcc";
	# 						level = 4;
	# 					}];
	# 				};
	# 				symlinks = {
	# 					mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
	# 						Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/Ow7wA0kG/lithium-fabric-0.21.4%2Bmc1.21.11.jar"; sha512 = "sha512-8UpcPS+teGNHyiUIP5AhOWlPYYt8EDlH8v0Genxe6Ipj4e+JJvfWk+p57X0A9XMXuud++cLWML9e0BrJenUrlA=="; };
	# 						Geyser = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/wQ026mlb/geyser-fabric-Geyser-Fabric-2.9.5-b1109.jar"; sha512 = "sha512-HQjHErH5EA+vDNkjOj3z02ALM7zgYMixORBikJa96GpLA66IqLJqJPoywZ+4SP/BEiNYVf+BsR5oxnJH4YjOaw=="; };
	# 						Floodgate = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/wzwExuYr/Floodgate-Fabric-2.2.6-b54.jar"; sha512 = "sha512-qugW2Y4iMxZ2AsBTvstD/7aIBFEpb6svPGps1Mi9yCCJVdc+EIn5rN2MHczueDXAsz/EJBOrMX2an+7nsp3hrw=="; }; # TODO
	# 						# FerriteCore = fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/ULSumfl4/ferritecore-6.0.0-forge.jar"; sha512 = "e78ddd02cca0a4553eb135dbb3ec6cbc59200dd23febf3491d112c47a0b7e9fe2b97f97a3d43bb44d69f1a10aad01143dcd84dc575dfa5a9eaa315a3ec182b37"; };
	# 						# Krypton = fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/jiDwS0W1/krypton-0.2.3.jar"; sha512 = "92b73a70737cfc1daebca211bd1525de7684b554be392714ee29cbd558f2a27a8bdda22accbe9176d6e531d74f9bf77798c28c3e8559c970f607422b6038bc9e"; };
	# 						# LazyDFU = fetchurl { url = "https://cdn.modrinth.com/data/hvFnDODi/versions/0.1.3/lazydfu-0.1.3.jar"; sha512 = "dc3766352c645f6da92b13000dffa80584ee58093c925c2154eb3c125a2b2f9a3af298202e2658b039c6ee41e81ca9a2e9d4b942561f7085239dd4421e0cce0a"; };
	# 						# C2ME = fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/t4juSkze/c2me-fabric-mc1.20.1-0.2.0%2Balpha.10.91.jar"; sha512 = "562c87a50f380c6cd7312f90b957f369625b3cf5f948e7bee286cd8075694a7206af4d0c8447879daa7a3bfe217c5092a7847247f0098cb1f5417e41c678f0c1"; };
	# 						# deps:
	# 						FabricAPI = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/i5tSkVBH/fabric-api-0.141.3%2B1.21.11.jar"; sha512 = "sha512-wgwBfiPW0ndGkNDdd0zshMFr+sVGHaLZNFoc2V7uSVsZVDM8Qh49HGYYYoTSSkM/awzO2AIfYuC/phfSOE0EcQ=="; }; # for TODO?
	# 					});
	# 				};
	# 			};
	#
	# 			# test-server-2 = {
	# 			# 	enable = true;
	# 			# 	autoStart = false;
	# 			# 	package = pkgs.fabricServers.fabric-26_1; # TODO?: 26.1.1
	# 			# 	serverProperties = {
	# 			# 		# src: https://minecraft.wiki/w/Server.properties
	# 			# 		# server-port = 25565;
	# 			# 		# "query.port" = 25565;
	# 			# 		# "rcon.port" = 25565;
	# 			# 		allow-flight = true;
	# 			# 		difficulty = "hard";
	# 			# 		enable-command-block = true;
	# 			# 		gamemode = "survival";
	# 			# 		level-seed = "42";
	# 			# 		motd = "stay silly~ :3";
	# 			# 		pause-when-empty-seconds = 5 * 60;
	# 			# 		simulation-distance = 10;
	# 			# 		view-distance = 10; # TODO: increase
	# 			# 		# jvmOpts = "-Xms6144M -Xmx8192M"; # TODO
	# 			# 	};
	# 			# 	files = { # mutable files
	# 			# 		"ops.json".value = [{
	# 			# 			name = "dmyTRUEk";
	# 			# 			uuid = "54aaf78f-3981-4997-bd69-7b5025dacdcc";
	# 			# 			level = 4;
	# 			# 		}];
	# 			# 	};
	# 			# 	symlinks = {
	# 			# 		mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
	# 			# 			# Lithium = pkgs.fetchurl { url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/kHXOBNih/lithium-fabric-0.23.0%2Bmc26.1.1.jar"; sha512 = "sha512-nX6S6ir30CTP4Jv8fqzyNuVR2gJPTd6zog2IsBvDYg7hxaM1UpnJ2/zHZAb7C44SGpiWUeanPIwmMikPhNuESA=="; }; # TODO
	# 			# 			# FerriteCore = fetchurl { url = "https://cdn.modrinth.com/data/uXXizFIs/versions/ULSumfl4/ferritecore-6.0.0-forge.jar"; sha512 = "e78ddd02cca0a4553eb135dbb3ec6cbc59200dd23febf3491d112c47a0b7e9fe2b97f97a3d43bb44d69f1a10aad01143dcd84dc575dfa5a9eaa315a3ec182b37"; };
	# 			# 			# Krypton = fetchurl { url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/jiDwS0W1/krypton-0.2.3.jar"; sha512 = "92b73a70737cfc1daebca211bd1525de7684b554be392714ee29cbd558f2a27a8bdda22accbe9176d6e531d74f9bf77798c28c3e8559c970f607422b6038bc9e"; };
	# 			# 			# LazyDFU = fetchurl { url = "https://cdn.modrinth.com/data/hvFnDODi/versions/0.1.3/lazydfu-0.1.3.jar"; sha512 = "dc3766352c645f6da92b13000dffa80584ee58093c925c2154eb3c125a2b2f9a3af298202e2658b039c6ee41e81ca9a2e9d4b942561f7085239dd4421e0cce0a"; };
	# 			# 			# C2ME = fetchurl { url = "https://cdn.modrinth.com/data/VSNURh3q/versions/t4juSkze/c2me-fabric-mc1.20.1-0.2.0%2Balpha.10.91.jar"; sha512 = "562c87a50f380c6cd7312f90b957f369625b3cf5f948e7bee286cd8075694a7206af4d0c8447879daa7a3bfe217c5092a7847247f0098cb1f5417e41c678f0c1"; };
	# 			# 		});
	# 			# 	};
	# 			# };
	#
	# 			# test-server-1 = {
	# 			# 	enable = true;
	# 			# 	autoStart = false;
	# 			# 	package = pkgs.vanillaServers.vanilla-1_21_4;
	# 			# 	serverProperties = {
	# 			# 		# server-port = 25565;
	# 			# 		allow-flight = true;
	# 			# 		difficulty = "hard";
	# 			# 		enable-command-block = true;
	# 			# 		gamemode = "survival";
	# 			# 		level-seed = "42";
	# 			# 		motd = "hell yeah";
	# 			# 		pause-when-empty-seconds = 60 * 60;
	# 			# 		# "query.port" = 25565;
	# 			# 		# simulation-distance = 10;
	# 			# 		# view-distance = 10;
	# 			# 	};
	# 			# 	files = { # mutable files
	# 			# 		"ops.json".value = [{
	# 			# 			name = "dmyTRUEk";
	# 			# 			uuid = "54aaf78f-3981-4997-bd69-7b5025dacdcc";
	# 			# 			level = 4;
	# 			# 		}];
	# 			# 	};
	# 			# };
	# 		};
	# 	};
	# };
}
