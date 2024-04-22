# programs.yazi.theme +=
{
	# based on: github.com/poperigby/gruvbox-dark-yazi
	manager = {
		cwd = { fg = "#83a598"; };

		# Hovered
		hovered         = { fg = "#282828"; bg = "#83a598"; };
		preview_hovered = { underline = true; };

		# Find
		find_keyword  = { fg = "#b8bb26"; italic = true; };
		find_position = { fg = "#fe8019"; bg = "reset"; italic = true; };

		# Marker
		marker_selected = { fg = "#b8bb26"; bg = "#b8bb26"; };
		marker_copied   = { fg = "#b8bb26"; bg = "#b8bb26"; };
		marker_cut      = { fg = "#fb4934"; bg = "#fb4934"; };

		# Tab
		tab_active   = { fg = "#aaff28"; bg = "#504945"; };
		tab_inactive = { fg = "#a89984"; bg = "#3c3836"; };
		tab_width    = 1;

		# Border
		border_symbol = "│";
		border_style  = { fg = "#665c54"; };

		# Highlighting
		# syntect_theme = "~/.config/yazi/Gruvbox-Dark.tmTheme"
	};
	status = {
		separator_open  = "";
		separator_close = "";
		separator_style = { fg = "#3c3836"; bg = "#3c3836"; };

		# Mode
		mode_normal = { fg = "#282828"; bg = "#a89984"; bold = true; };
		mode_select = { fg = "#282828"; bg = "#b8bb26"; bold = true; };
		mode_unset  = { fg = "#282828"; bg = "#d3869b"; bold = true; };

		# Progress
		progress_label  = { fg = "#ebdbb2"; bold = true; };
		progress_normal = { fg = "#504945"; bg = "#3c3836"; };
		progress_error  = { fg = "#fb4934"; bg = "#3c3836"; };

		# Permissions
		permissions_t = { fg = "#504945"; };
		permissions_r = { fg = "#b8bb26"; };
		permissions_w = { fg = "#fb4934"; };
		permissions_x = { fg = "#b8bb26"; };
		permissions_s = { fg = "#665c54"; };
	};
	input = {
		border   = { fg = "#504945"; };
		title    = {};
		value    = {};
		selected = { reversed = true; };
	};
	select = {
		border   = { fg = "#504945"; };
		active   = { fg = "#fe8019"; };
		inactive = {};
	};
	tasks = {
		border  = { fg = "#504945"; };
		title   = {};
		hovered = { underline = true; };
	};
	which = {
		mask            = { bg = "#3c3836"; };
		cand            = { fg = "#83a598"; };
		rest            = { fg = "#928374"; };
		desc            = { fg = "#fe8019"; };
		separator       = "  ";
		separator_style = { fg = "#504945"; };
	};
	help = {
		on      = { fg = "#fe8019"; };
		exec    = { fg = "#83a598"; };
		desc    = { fg = "#928374"; };
		hovered = { bg = "#504945"; bold = true; };
		footer  = { fg = "#3c3836"; bg = "#a89984"; };
	};
	filetype = {
		rules = [
			# Images
			{ mime = "image/*"; fg = "#83a598"; }

			# Videos
			{ mime = "video/*"; fg = "#b8bb26"; }
			{ mime = "audio/*"; fg = "#b8bb26"; }

			# Archives
			{ mime = "application/zip";             fg = "#fe8019"; }
			{ mime = "application/gzip";            fg = "#fe8019"; }
			{ mime = "application/x-tar";           fg = "#fe8019"; }
			{ mime = "application/x-bzip";          fg = "#fe8019"; }
			{ mime = "application/x-bzip2";         fg = "#fe8019"; }
			{ mime = "application/x-7z-compressed"; fg = "#fe8019"; }
			{ mime = "application/x-rar";           fg = "#fe8019"; }

			# Fallback
			{ name = "*" ; fg = "#a89984"; }
			{ name = "*/"; fg = "#83a598"; }
		];
	};
}
