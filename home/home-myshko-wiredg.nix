{
	inputs,
	lib,
	config,
	pkgs,
	pkgs_for_wm,
	...
}: {
	programs = {};

	home.packages = with pkgs; [ # PKGS
		pkgs_for_wm.mathematica # wolfram mathematica 14.1

		(haskellPackages.ghcWithPackages (haskell-pkgs: with haskell-pkgs; [
			# haskell pkgs
			hoogle
			flow # alt syntax for composition operators
			extra # extra fns
			split # split fns
			safe # safe list fns
			combinators # not combinators
			foldl # foldl
		]))
		haskell-language-server

		ocaml
		ocamlPackages.utop # better repl
		#dune # pkg manager
		#opam # project manager
	];
}
