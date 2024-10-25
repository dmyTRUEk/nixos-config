{
	description = "dmyTRUEk's cool NixOS config for all *wired* PCs";

	inputs = {
		#nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			#url = "github:nix-community/home-manager/release-23.11";
			url = "github:nix-community/home-manager/master";
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
		#pkgs = nixpkgs.legacyPackages.${system};  #f2ef04 same?
		#pkgs = import stable { inherit system; }; #f2ef04 same?
		pkgs = import nixpkgs { inherit system; }; #f2ef04 same?
	in {
		# NixOS configuration entrypoint
		# Available through 'nixos-rebuild --flake .#your-hostname'
		nixosConfigurations = {
			psyche = nixpkgs.lib.nixosSystem {
				modules = [
					./os/configuration-common.nix
					./os/configuration-psyche.nix
				];
			};
			knight = nixpkgs.lib.nixosSystem {
				modules = [
					./os/configuration-common.nix
					./os/configuration-knight.nix
				];
			};
		};

		# Standalone home-manager configuration entrypoint
		# Available through 'home-manager --flake .#your-username@your-hostname'
		homeConfigurations = {
			"myshko@psyche" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = { inherit inputs; };
				modules = [
					./home/home-common.nix
					./home/home-psyche.nix
					anyrun.homeManagerModules.default
				];
			};
			"myshko@knight" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				extraSpecialArgs = { inherit inputs; };
				modules = [
					./home/home-common.nix
					./home/home-knight.nix
					anyrun.homeManagerModules.default
				];
			};
		};
	};
}
