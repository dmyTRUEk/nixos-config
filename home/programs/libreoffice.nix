{ pkgs, ... }: {
	home.packages = with pkgs; [
		libreoffice-fresh # TODO(refactor): use new name
		hunspell
		hunspellDicts.en_US-large # for libreoffice ENG spellcheck
		hunspellDicts.uk_UA       # for libreoffice UKR spellcheck
	];
}
