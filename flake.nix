{
	description = "dmyTRUEk's cool NixOS config for all *wired* PCs";

	inputs = {
		#nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		# nixpkgs at 2025-01-24, for wolfram mathematica 14.1
		nixpkgs_for_wm.url = "github:NixOS/nixpkgs/a85fc0af456a898b7a4c459f38429e05df958907";

		# nixpkgs at 2026-08-01, tmp for lean4
		#nixpkgs_for_lean.url = "github:NixOS/nixpkgs/8479b32a9fa421bf79a2e143f367d11a304f14f8"; # not working commit
		nixpkgs_for_lean.url = "github:NixOS/nixpkgs/0f9a3c53a31c80fdff0f7aa7fc6b808d4327d333"; # working commit

		home-manager = {
			#url = "github:nix-community/home-manager/release-23.11";
			#url = "github:nix-community/home-manager/master";
			url = "github:nix-community/home-manager"; # src: https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#hardware.url = "github:NixOS/nixos-hardware";

		nix-minecraft = {
			url = "github:Infinidoge/nix-minecraft";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		peeky = {
			#url = "path:////home/myshko/Projects/peeky";
			url = "github:dmyTRUEk/peeky";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#plasma-manager = {
		#	url = "github:nix-community/plasma-manager";
		#	inputs.nixpkgs.follows = "nixpkgs";
		#};
	};

	outputs = inputs @ {
		nixpkgs,
		home-manager,
		peeky,
		...
	}:
	let
		system = "x86_64-linux";
		nixosSystem = nixpkgs.lib.nixosSystem;
		hostname_psyche = "psyche";
		hostname_knight = "knight";
		hostname_wiredg = "wiredg";
		home-manager-module = home-manager.nixosModules.home-manager;
		username_myshko = "myshko";
		username_guest  = "guest";
		pkgs_for_wm = import inputs.nixpkgs_for_wm { inherit system; config.allowUnfree = true; };
		pkgs_for_lean = import inputs.nixpkgs_for_lean { inherit system; };
	in {
		# src: https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
		nixosConfigurations = {
			${hostname_psyche} = nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; }; # allows access to flake inputs in nixos modules
				modules = [
					./os/configuration-common.nix
					./os/configuration-${hostname_psyche}.nix
					home-manager-module {
						home-manager = {
							verbose = true;
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { # allows access to flake inputs in hm modules
								inherit
									inputs
									pkgs_for_wm
									pkgs_for_lean
									peeky
								;
							};
							backupFileExtension = "backup";
							users = {
								${username_myshko}.imports = [
									./home/home-common-common.nix
									./home/home-common-${hostname_psyche}.nix
									./home/home-${username_myshko}-common.nix
									./home/home-${username_myshko}-${hostname_psyche}.nix
								];
								${username_guest}.imports = [
									./home/home-common-common.nix
									./home/home-common-${hostname_psyche}.nix
									./home/home-${username_guest}-common.nix
									./home/home-${username_guest}-${hostname_psyche}.nix
								];
							};
						};
					}
				];
			};
			${hostname_knight} = nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; }; # allows access to flake inputs in nixos modules
				modules = [
					./os/configuration-common.nix
					./os/configuration-${hostname_knight}.nix
					home-manager-module {
						home-manager = {
							verbose = true;
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { # allows access to flake inputs in hm modules
								inherit
									inputs
									pkgs_for_wm
									pkgs_for_lean
									peeky
								;
							};
							backupFileExtension = "backup";
							users = {
								${username_myshko}.imports = [
									./home/home-common-common.nix
									./home/home-common-${hostname_knight}.nix
									./home/home-${username_myshko}-common.nix
									./home/home-${username_myshko}-${hostname_knight}.nix
								];
								${username_guest}.imports = [
									./home/home-common-common.nix
									./home/home-common-${hostname_knight}.nix
									./home/home-${username_guest}-common.nix
									./home/home-${username_guest}-${hostname_knight}.nix
								];
							};
						};
					}
				];
			};
			${hostname_wiredg} = nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; }; # allows access to flake inputs in nixos modules
				modules = [
					./os/configuration-common.nix
					./os/configuration-${hostname_wiredg}.nix
					home-manager-module {
						home-manager = {
							verbose = true;
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { # allows access to flake inputs in hm modules
								inherit
									inputs
									pkgs_for_wm
									pkgs_for_lean
									peeky
								;
							};
							backupFileExtension = "backup";
							users = {
								${username_myshko}.imports = [
									./home/home-common-common.nix
									./home/home-common-${hostname_wiredg}.nix
									./home/home-${username_myshko}-common.nix
									./home/home-${username_myshko}-${hostname_wiredg}.nix
								];
								${username_guest}.imports = [
									./home/home-common-common.nix
									./home/home-common-${hostname_wiredg}.nix
									./home/home-${username_guest}-common.nix
									./home/home-${username_guest}-${hostname_wiredg}.nix
								];
							};
						};
					}
				];
			};
		};
	};
}
