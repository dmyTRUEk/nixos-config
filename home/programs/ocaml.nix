{ pkgs, ... }: {
	home.packages = with pkgs; [
		ocaml
		ocamlPackages.utop # better repl
		#dune # pkg manager
		#opam # project manager
	];
}
