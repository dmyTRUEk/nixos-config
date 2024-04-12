# programs.anyrun =
{ inputs, pkgs, ... }: {
	enable = true;
	extraCss = import ./anyrun-theme.nix;
	config = {
		plugins = with inputs.anyrun.packages.${pkgs.system}; [
			# An array of all the plugins you want, which either can be packages, or paths to the .so files
			#./some_plugin.so

			#anyrun_macros
			applications
			dictionary
			#kidex
			#randr
			rink # calculator & units convertor
			#shell
			#stdin
			symbols
			translate
			#websearch
		];
		x = { fraction = .5; };
		y = { fraction = .5; };
		width = { fraction = .4; };
		height = { fraction = .5; };
		hideIcons = false;
		ignoreExclusiveZones = false;
		layer = "overlay";
		hidePluginInfo = false;
		closeOnClick = false;
		showResultsImmediately = true;
		maxEntries = null;
	};
	extraConfigFiles."symbols.ron".text = ''
		Config(
			// The prefix that the search needs to begin with to yield symbol results
			prefix: "",
			// Custom user defined symbols to be included along the unicode symbols
			symbols: {
				"approximately equal to": "≈",
				"...": "…",
				"lorem ipsum": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
				"fumo happy round": "ᗜᴗᗜ",
				"fumo happy triangle": "ᗜˬᗜ",
				"fumo sad round": "ᗜ⁔ᗜ",
				"fumo sad triangle": "ᗜ˰ᗜ",
			},
			max_entries: 10,
		)
	'';
}
