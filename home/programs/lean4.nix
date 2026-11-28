{ pkgs, ... }: {
	home.packages = with pkgs; [
		lean4
		#leanPackages.mathlib # conflicts with lean4 license
		#(lib.lowPrio leanPackages.mathlib) # fixes for conflict with lean4 license, but not usable in projects?
		#leanPackages.batteries
	];
}
