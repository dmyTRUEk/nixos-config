-- yazi init.lua

require("sort-rules"):setup {
	dir_first = true,
	default = "natural",
	rules = {
		mtime_reverse = {
			"Downloads",
			"Downloads/Telegram Desktop",
			"Projects",
			"Videos",
			--"/nix/store", -- start with `/` for abs path
			--"Music/", -- end with `/` for all deeper paths too
		},
		natural_reverse = {
			"Pictures/Screenshots/2026",
			"Dropbox/Work/docs/",
			"Dropbox/Work/files/",
			"Dropbox/Work/my_files/",
			"Dropbox/Work/wolfram_mathematica/",
		},
	},
}

