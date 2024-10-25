# programs.anyrun =
{ inputs, pkgs, ... }: {
	enable = true;
	extraCss = import ./anyrun-theme.nix;
	extraConfigFiles."symbols.ron".text = builtins.readFile ./anyrun.symbols.ron;
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
}
