{ pkgs, ... }: {
	home.packages = with pkgs; [
		(julia.withPackages [
			"IJulia" # for jupyter
			#"Symbolics" # for symbolic calculations
		])
	];
}
