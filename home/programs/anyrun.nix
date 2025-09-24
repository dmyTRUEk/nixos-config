# programs.anyrun =
{ inputs, pkgs, ... }: {
	enable = true;
	#package = inputs.anyrun.packages.${pkgs.system}.anyrun;
	extraCss = builtins.readFile ./anyrun-theme.css;
	extraConfigFiles."symbols.ron".text = builtins.readFile ./anyrun.symbols.ron;
	config = {
		plugins =
		#with inputs.anyrun.packages.${pkgs.system};
		[
			# An array of all the plugins you want, which either can be packages, or paths to the .so files
			#./some_plugin.so

			# #anyrun_macros
			# applications
			# dictionary
			# #kidex
			# #randr
			# rink # calculator & units convertor
			# #shell
			# #stdin
			# symbols
			# translate
			# #websearch

			"${pkgs.anyrun}/lib/libapplications.so"
			"${pkgs.anyrun}/lib/libdictionary.so"
			"${pkgs.anyrun}/lib/librink.so"
			"${pkgs.anyrun}/lib/libsymbols.so"
			"${pkgs.anyrun}/lib/libtranslate.so"

			# "${inputs.anyrun.packages.${pkgs.system}.anyrun}/lib/libapplications.so"
			# "${inputs.anyrun.packages.${pkgs.system}.anyrun}/lib/libdictionary.so"
			# "${inputs.anyrun.packages.${pkgs.system}.anyrun}/lib/librink.so"
			# "${inputs.anyrun.packages.${pkgs.system}.anyrun}/lib/libsymbols.so"
			# "${inputs.anyrun.packages.${pkgs.system}.anyrun}/lib/libtranslate.so"
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
