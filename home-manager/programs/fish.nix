# programs.fish =
{
	enable = true;
	shellAliases = import ./fish-aliases.nix;
	shellInit = builtins.readFile ./fish-extra-shell-init.fish;
}
