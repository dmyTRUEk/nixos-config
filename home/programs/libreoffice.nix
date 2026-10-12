{ pkgs, ... }: {
	home.packages = with pkgs; [
		libreoffice
		hunspell
		hunspellDicts.en_US-large # for libreoffice ENG spellcheck
		hunspellDicts.uk_UA       # for libreoffice UKR spellcheck
	];
}
