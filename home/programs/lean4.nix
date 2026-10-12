{ pkgs, ... }: {
	home.packages = with pkgs; [
		lean4
		#leanPackages.mathlib
		#leanPackages.batteries
	];
}
