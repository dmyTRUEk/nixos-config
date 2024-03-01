{
	description = "My cool nix config";

	inputs = {
		# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
		#nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# Home manager
		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			#url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# TODO: Add any other flake you might need
		# hardware.url = "github:nixos/nixos-hardware";

		# Shameless plug: looking for a way to nixify your themes and make
		# everything match nicely? Try nix-colors!
		# nix-colors.url = "github:misterio77/nix-colors";
	};

	outputs = {
		nixpkgs,
		home-manager,
		...
	}:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};    #f2ef04 same?
		#pkgs = import stable { inherit system; };  #f2ef04 same?
	in {
		# NixOS configuration entrypoint
		# Available through 'nixos-rebuild --flake .#your-hostname'
		nixosConfigurations = {
			acer-nixos = nixpkgs.lib.nixosSystem {
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
			# or "myshko@acer-nixos"?
			"myshko" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs; #d868c3 same?
				#pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance #d868c3 same?

				# TODO: enable?
				#extraSpecialArgs = { inherit inputs outputs; };

				# > Main home-manager configuration file <
				modules = [ ./home-manager/home.nix ];
			};
		};
	};
}
