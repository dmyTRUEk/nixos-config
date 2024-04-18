{
	description = "My cool nix config";

	inputs = {
		# Nixpkgs
		#nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		# Home manager
		home-manager = {
			#url = "github:nix-community/home-manager/release-23.11";
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# TODO: Add any other flake you might need
		# hardware.url = "github:NixOS/nixos-hardware";

		# Shameless plug: looking for a way to nixify your themes and make
		# everything match nicely? Try nix-colors!
		# nix-colors.url = "github:misterio77/nix-colors";

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
				# TODO: enable?
				#system = "x86_64-linux";

				# TODO: enable?
				#specialArgs = { inherit inputs outputs; };

				# > Main nixos configuration file <
				modules = [ ./nixos/configuration.nix ];
			};
		};

		# Standalone home-manager configuration entrypoint
		# Available through 'home-manager --flake .#your-username@your-hostname'
		homeConfigurations = {
			# or "myshko@psyche"?
			"myshko" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				extraSpecialArgs = { inherit inputs; };

				# > Main home-manager configuration file <
				modules = [
					./home-manager/home.nix
					anyrun.homeManagerModules.default
				];
			};
		};
	};
}
