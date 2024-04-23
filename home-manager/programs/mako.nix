# services.mako =
{ config, ... }: {
	enable = true;
	sort = "+time";
	font = "JetBrains Mono 10";
	width  = 300;
	height = 100;
	borderRadius = 10;
	#borderSize = 1;
	groupBy = "summary";
	maxVisible = 3;
	layer = "overlay";
	anchor = "bottom-right";

	# TODO(refactor): `with config.colorScheme.palette` ...
	backgroundColor = "#${config.colorScheme.palette.base01}";
	textColor       = "#${config.colorScheme.palette.base07}";
	borderColor     = "#${config.colorScheme.palette.base00}";
	#borderColor    = "#000000";
	#progressColor  = "#${config.colorScheme.palette.base00}";

	#extraConfig = ''
	#	[mode=do-not-disturb]
	#	invisible=1
	#'';
}
