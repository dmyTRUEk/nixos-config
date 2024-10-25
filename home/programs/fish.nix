# programs.fish =
{ lib, ... }: {
	enable = true;
	shellAliases = import ./fish-aliases.nix;
	shellInit = lib.strings.concatMapStringsSep "\n" builtins.readFile [
		./fish-extra-shell-init.fish
		./fish-extra-shell-init-nixos.fish
	];
}
