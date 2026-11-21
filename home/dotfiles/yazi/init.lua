-- yazi init.lua

require("sort-rules"):setup {
	dir_first = true,
	default = "natural",
	rules = {
		mtime_reverse = {
			"Downloads",
			"Downloads/Telegram Desktop",
			"Projects",
			"Videos"
			--"/nix/store", -- start with `/` for abs path
		},
		natural_reverse = {
			"Pictures/Screenshots/2026",
		},
	},
}

