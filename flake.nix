{
	description = "dmyTRUEk's cool NixOS config for all *wired* PCs";

	inputs = {
		#nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		# nixpkgs at 2025-01-24, for wolfram mathematica 14.1
		nixpkgs_for_wm.url = "github:NixOS/nixpkgs/a85fc0af456a898b7a4c459f38429e05df958907";

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

		futhark = {
			url = "github:diku-dk/futhark";
			inputs.nixpkgs.follows = "nixpkgs";
		};
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
		home-manager-module = home-manager.nixosModules.home-manager;
		#username_myshko = "myshko";  # TODO: change to just `m`
		pkgs_for_wm = import inputs.nixpkgs_for_wm { inherit system; config.allowUnfree = true; };
	in {
		# src: https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nixos-module
		nixosConfigurations = {
			psyche = nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; }; # allows access to flake inputs in nixos modules
				modules = [
					./os/configuration-common.nix
					./os/configuration-psyche.nix
					home-manager-module {
						home-manager = {
							verbose = true;
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { # allows access to flake inputs in hm modules
								inherit
									inputs
									pkgs_for_wm
									peeky  # TODO: remove, and use `inputs. ...`
								;
							};
							backupFileExtension = "backup";
							users = {
								m.imports = [
									# TODO?: use `any` (or `all`?) instead of `common`
									./home/home-common-common.nix
									./home/home-common-myshko.nix
									./home/home-psyche-common.nix
									./home/home-psyche-myshko.nix
								];
								guest.imports = [
									# TODO?: use `any` (or `all`?) instead of `common`
									./home/home-common-common.nix
									./home/home-common-guest.nix
									./home/home-psyche-common.nix
									./home/home-psyche-guest.nix
								];
							};
						};
					}
				];
			};
			knight = nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; }; # allows access to flake inputs in nixos modules
				modules = [
					./os/configuration-common.nix
					./os/configuration-knight.nix
					home-manager-module {
						home-manager = {
							verbose = true;
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { # allows access to flake inputs in hm modules
								inherit
									inputs
									pkgs_for_wm
									peeky  # TODO: remove, and use `inputs. ...`
								;
							};
							backupFileExtension = "backup";
							users = {
								m.imports = [
									# TODO?: use `any` (or `all`?) instead of `common`
									./home/home-common-common.nix
									./home/home-common-myshko.nix
									./home/home-knight-common.nix
									./home/home-knight-myshko.nix
								];
								guest.imports = [
									# TODO?: use `any` (or `all`?) instead of `common`
									./home/home-common-common.nix
									./home/home-common-guest.nix
									./home/home-knight-common.nix
									./home/home-knight-guest.nix
								];
							};
						};
					}
				];
			};
			wiredg = nixosSystem {
				inherit system;
				specialArgs = { inherit inputs; }; # allows access to flake inputs in nixos modules
				modules = [
					./os/configuration-common.nix
					./os/configuration-wiredg.nix
					home-manager-module {
						home-manager = {
							verbose = true;
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { # allows access to flake inputs in hm modules
								inherit
									inputs
									pkgs_for_wm
									peeky  # TODO: remove, and use `inputs. ...`
								;
							};
							backupFileExtension = "backup";
							users = {
								myshko.imports = [
									# TODO?: use `any` (or `all`?) instead of `common`
									./home/home-common-common.nix
									./home/home-common-myshko.nix
									./home/home-wiredg-common.nix
									./home/home-wiredg-myshko.nix
								];
								guest.imports = [
									# TODO?: use `any` (or `all`?) instead of `common`
									./home/home-common-common.nix
									./home/home-common-guest.nix
									./home/home-wiredg-common.nix
									./home/home-wiredg-guest.nix
								];
							};
						};
					}
				];
			};
		};
	};
}
