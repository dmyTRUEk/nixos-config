{
	description = "dmyTRUEk's cool NixOS config for all *wired* PCs";

	inputs = {
		#nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			#url = "github:nix-community/home-manager/release-23.11";
			# url = "github:nix-community/home-manager/master";
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# TODO: Add any other flake you might need
		# hardware.url = "github:NixOS/nixos-hardware";

		nix-colors.url = "github:misterio77/nix-colors";

		anyrun = {
			url = "github:Kirottu/anyrun";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ {
		nixpkgs,
		home-manager,
		anyrun,
		...
	}:
	let
		system = "x86_64-linux";
		nixosSystem = nixpkgs.lib.nixosSystem;
		hostname_psyche = "psyche";
		hostname_knight = "knight";
		home-manager-module = home-manager.nixosModules.home-manager;
		username_myshko = "myshko";
		username_guest  = "guest";
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
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { inherit inputs; }; # allows access to flake inputs in hm modules
							backupFileExtension = "backup";
							users = {
								${username_myshko}.imports = [
									./home/home-common-common.nix
									./home/home-${username_myshko}-common.nix
									./home/home-${username_myshko}-${hostname_psyche}.nix
									anyrun.homeManagerModules.default
								];
								${username_guest}.imports = [
									./home/home-common-common.nix
									./home/home-${username_guest}-common.nix
									./home/home-${username_guest}-${hostname_psyche}.nix
									anyrun.homeManagerModules.default
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
							useGlobalPkgs = true; # makes hm use nixos's pkgs value
							useUserPackages = true; # ?
							extraSpecialArgs = { inherit inputs; }; # allows access to flake inputs in hm modules
							users = {
								${username_myshko}.imports = [
									./home/home-common-common.nix
									./home/home-${username_myshko}-common.nix
									./home/home-${username_myshko}-${hostname_knight}.nix
									anyrun.homeManagerModules.default
								];
								${username_guest}.imports = [
									./home/home-common-common.nix
									./home/home-${username_guest}-common.nix
									./home/home-${username_guest}-${hostname_knight}.nix
									anyrun.homeManagerModules.default
								];
							};
						};
					}
				];
			};
		};
	};
}
