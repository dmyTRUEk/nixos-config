{
	enable = true;
	#enableFishIntegration = true; # it's just `yazi_with_cwd_memory`
	settings = {
		manager = {
			sort_by = "natural";
			# TODO: reverse sort Pictures, sort by time Telegram
			sort_sensitive = false; # case sensitive
			#sort_reverse = true; # TODO: enable for screenshots
			sort_dir_first = true;
			linemode = "size";
			show_hidden = false;
			show_symlink = true;
			scrolloff = 10;
		};
		preview = {
			# $ yazi --clear-cache
			tab_size = 4;
			# image max sizes (dont load if more than):
			max_width  = 4000;
			max_height = 4000;
			image_filter = "triangle";
			image_quality = 50;
		};
		opener = {
			text = [{ run = ''nvim "$@"''; block = true; }];
			image = [{ run = ''swayimg "$@"''; } { run = ''krita "$@"''; }];
			video = [{ run = ''vlc "$@"''; }];
			audio = [{ run = ''vlc "$@"''; }];
			kdenlive = [{ run = ''kdenlive "$@"''; }];
			pdf = [{ run = ''zathura "$@"''; }];
		};
		open = {
			rules = [
				{ name = "*.kdenlive"; use = "kdenlive"; }
				{ mime = "text/*"; use = "text"; }
				{ mime = "image/*"; use = "image"; }
				{ mime = "video/*"; use = "video"; }
				{ mime = "application/pdf"; use = "pdf"; }
				{ name = "*.mp3"; use = "audio"; }
				{ name = "*.wav"; use = "audio"; }
				# Multiple openers for a single rule
				#{ name = "*.html", use = [ "browser", "text" ] },
			];
		};
	};
	keymap = {
		# some default keymaps: yazi-rs.github.io/docs/quick-start
		# ALL default keymaps: github.com/sxyazi/yazi/blob/latest/yazi-config/preset/keymap.toml
		manager = {
			prepend_keymap = [
				{ on = ["Q"]; run = "quit";  desc = "Quit"; }
				{ on = ["q"]; run = "close"; desc = "Close current tab or quit if last"; }
				{ on = ["c" "c"]; run = ''shell 'filename="$1" && wl-copy "file://$filename" --type text/uri-list' --confirm''; desc = "Copy file using URI (file://)"; }
				{ on = ["<C-d>"]; run = ''shell "$SHELL" --block --confirm''; desc = "Open shell here"; }
				{ on = ["<C-j>"]; run = "arrow  50%"; desc = "Move cursor half page down"; }
				{ on = ["<C-k>"]; run = "arrow -50%"; desc = "Move cursor half page up"; }
				{ on = ["u"]; run = "shell 'dua i' --block --confirm"; desc = "Disk Usage (dua i)"; }
				{ on = ["s"]; run = "search fd"; desc = "Search files by name using fd"; }
				{ on = ["S"]; run = "search rg"; desc = "Search files by content using ripgrep"; }
				#{ on = ["<C-s>"]; run = "search none"; desc = "Cancel the ongoing search"; }

				# basic:
				{ on = ["g" "/"]; run = "cd /"; }
				#{ on = ["g" ""]; run = "cd /tmp"; }
				{ on = ["g" "h"]; run = "cd ~"; }
				{ on = ["g" "T"]; run = "cd ~/.local/share/Trash/files"; }
				# home:
				{ on = ["g" "c"]; run = "cd ~/projects"; }
				{ on = ["g" "o"]; run = "cd ~/Documents"; }
				{ on = ["g" "d"]; run = "cd ~/Downloads"; }
				{ on = ["g" "t"]; run = "cd '~/Downloads/Telegram Desktop'"; }
				{ on = ["g" "r"]; run = "cd ~/Dropbox"; }
				{ on = ["g" "u"]; run = "cd ~/Dropbox/University/Mast4"; }
				{ on = ["g" "m"]; run = "cd ~/Music"; }
				{ on = ["g" "p"]; run = "cd ~/Pictures"; }
				{ on = ["g" "s"]; run = "cd ~/Pictures/Screenshots"; }
				{ on = ["g" "v"]; run = "cd ~/Videos"; }
				# games:
				{ on = ["g" "a" "c"]; run = "cd ~/.local/share/Celeste/Saves"; }
				{ on = ["g" "a" "3"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/374320/pfx/drive_c/users/steamuser/AppData/Roaming/DarkSoulsIII"; }
				{ on = ["g" "a" "e"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/1245620/pfx/drive_c/users/steamuser/AppData/Roaming/EldenRing"; }
			];
		};
	};
	theme = {
		icon = {
			prepend_rules = [
				{ name = "Documents/"; text = "󰈙"; }
				{ name = "Music/"; text = "󰎈"; }
				{ name = "*.mp3"; text = "󰎈"; }
				{ name = "*.wav"; text = "󰎈"; }
				{ name = "Public/"; text = "󰮮"; }
				{ name = "Cargo.lock"; text = ""; }
				{ name = "*.yaml"; text = ""; }
			];
		};
	} // (
		import ./yazi-theme-gruvbox.nix
	);
}
