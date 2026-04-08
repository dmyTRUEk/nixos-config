{ lib, ... }: {
	imports = [
		./fish-aliases.nix
	];

	programs.fish = {
		enable = true;
		shellInit = lib.strings.concatMapStringsSep "\n" builtins.readFile [
			./fish-extra-shell-init.fish
			./fish-extra-shell-init-nixos.fish
		];
	};
}
