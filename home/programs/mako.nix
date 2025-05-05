# services.mako =
{ config, ... }: {
	enable = true;
	settings = {
		sort = "-time";
		font = "JetBrains Mono 10";
		#width  = 300;
		#height = 100;
		#borderSize = 1;
		group-by = "summary";
		max-visible = 5;
		max-history = 1000;
		layer = "overlay";
		anchor = "bottom-right";
		outer-margin = "10,0";
		#margin = "";
		#padding = "";

		border-radius = 10;

		# TODO(refactor): `with config.colorScheme.palette` ...
		background-color = "#222222";
		text-color       = "#ffffff";
		border-color     = "#000000";
		#backgroundColor = "#${config.colorScheme.palette.base01}";
		#textColor       = "#${config.colorScheme.palette.base07}";
		#borderColor     = "#${config.colorScheme.palette.base00}";
		#progressColor   = "#${config.colorScheme.palette.base00}";
	};
}
