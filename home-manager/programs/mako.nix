# services.mako =
{ config, ... }: {
	enable = true;
	sort = "-time";
	font = "JetBrains Mono 10";
	#width  = 300;
	#height = 100;
	#borderSize = 1;
	groupBy = "summary";
	maxVisible = 5;
	#maxHistory = 1000;
	layer = "overlay";
	anchor = "bottom-right";
	#outerMargin = "20";
	#margin = "";
	#padding = "";

	borderRadius = 10;

	# TODO(refactor): `with config.colorScheme.palette` ...
	backgroundColor = "#222222";
	textColor       = "#ffffff";
	borderColor     = "#000000";
	#backgroundColor = "#${config.colorScheme.palette.base01}";
	#textColor       = "#${config.colorScheme.palette.base07}";
	#borderColor     = "#${config.colorScheme.palette.base00}";
	#progressColor   = "#${config.colorScheme.palette.base00}";

	extraConfig =
	let
		extraOptions = {
			outer-margin = "10,0";
			max-history = 1000;
		};
	in
		builtins.concatStringsSep "\n" (
			map (
				key:
				let value = toString extraOptions.${key};
				in "${key}=${value}"
			)
			(builtins.attrNames extraOptions)
		);
}
