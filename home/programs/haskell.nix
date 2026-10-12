{ pkgs, ... }: {
	home.packages = with pkgs; [
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
	];
}
