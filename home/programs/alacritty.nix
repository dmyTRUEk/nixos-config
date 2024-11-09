# programs.alacritty =
{ config, ... }: {
	enable = true;
	settings = {
		general.live_config_reload = true;

		cursor.style.shape = "Block";

		# [hints.mouse]
		# enabled = true

		scrolling = {
			# auto_scroll = false
			# faux_multiplier = 1
			history = 10000;
			multiplier = 3;
		};

		selection = {
			save_to_clipboard = false;
		};

		window = {
			dynamic_title = true;
			opacity = 1.0;
		};

		font = {
			builtin_box_drawing = true;
			size = 13.0;
			normal      = { family = "JetBrains Mono"; style = "Regular"; };
			bold        = { family = "JetBrains Mono"; style = "Bold"; };
			italic      = { family = "JetBrains Mono"; style = "Italic"; };
			bold_italic = { family = "JetBrains Mono"; style = "Bold Italic"; };
		};

		keyboard.bindings = [
			{ key = "C"; mods = "Control|Shift"; action = "Copy"; }
			{ key = "V"; mods = "Control|Shift"; action = "Paste"; }
			{ key = "Escape"; mode = "Vi|~Search"; action = "ToggleViMode"; }
			{ key = "J"; mods = "Control"; mode = "Vi|~Search"; action = "ScrollHalfPageDown"; }
			{ key = "K"; mods = "Control"; mode = "Vi|~Search"; action = "ScrollHalfPageUp"; }

			# TODO: center after `n` -> `nz`
			# alacritty msg -s ? CenterAroundViCursor
			{ key = "N"; mode = "Vi|~Search"; action = "SearchNext"; }

			# TODO: dynamic window transparency/opacity
			# - { key: Equals, mods: Control|Shift, action: IncreaseWindowOpacity }
			# - { key: Minus,  mods: Control|Shift, action: DecreaseWindowOpacity }
		];

		colors = with config.colorScheme.palette; {
			primary = {
				background = "0x282828";
				foreground = "0xc5c8c6";
				# background = "0x${base00}";
				# foreground = "0x${base07}";
			};
			#cursor = {
			#	cursor = "0x${base06}";
			#	text = "0x${base06}";
			#};
			#normal = {
			#	black = "0x${base00}";
			#	blue = "0x${base0D}";
			#	cyan = "0x${base0C}";
			#	green = "0x${base0B}";
			#	magenta = "0x${base0E}";
			#	red = "0x${base08}";
			#	white = "0x${base06}";
			#	yellow = "0x${base0A}";
			#};
			#bright = {
			#	black = "0x${base00}";
			#	blue = "0x${base0D}";
			#	cyan = "0x${base0C}";
			#	green = "0x${base0B}";
			#	magenta = "0x${base0E}";
			#	red = "0x${base08}";
			#	white = "0x${base06}";
			#	yellow = "0x${base09}";
			#};
		};
	};
}
