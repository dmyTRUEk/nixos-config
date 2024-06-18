# programs.yazi =
{
	enable = true;
	#enableFishIntegration = true; # it's just `yazi_with_cwd_memory`
	settings = {
		manager = {
			sort_by = "natural";
			# TODO: reverse sort Pictures/Screenshots, sort by time Telegram
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
			text = [
				{ run = ''nvim "$@"''; block = true; }
				#{ run = ''xdg-open "$@"''; } # TODO: fix
			];
			image = [
				{ run = ''swayimg "$@"''; }
				{ run = ''krita "$@"''; }
				{ run = ''gwenview "$@"''; }
			];
			video = [{ run = ''vlc "$@"''; }];
			audio = [{ run = ''vlc "$@"''; }];
			kdenlive = [{ run = ''kdenlive "$@"''; }];
			pdf = [{ run = ''zathura "$@"''; }];
			libreoffice = [{ run = ''libreoffice "$@"''; }];
			djvu = [{ run = ''zathura "$@"''; }];
			krita_project = [{ run = ''krita "$@"''; }];
			#markdown = [];
		};
		open = {
			rules = [
				{ name = "*.kdenlive"; use = "kdenlive"; }
				{ name = "*.kra"; use = "krita_project"; }
				{ name = "*.djvu"; use = "djvu"; }
				#{ name = "*.md"; use = "markdown"; }

				{ mime = "text/*"; use = "text"; }
				{ mime = "image/*"; use = "image"; }
				{ mime = "video/*"; use = "video"; }
				{ mime = "application/pdf"; use = "pdf"; }

				{ name = "*.mp3"; use = "audio"; }
				{ name = "*.wav"; use = "audio"; }
				{ name = "*.ogg"; use = "audio"; }

				{ name = "*.odt"; use = "libreoffice"; }
				{ name = "*.odp"; use = "libreoffice"; }
				{ name = "*.ods"; use = "libreoffice"; }

				{ name = "*.doc" ; use = "libreoffice"; }
				{ name = "*.docx"; use = "libreoffice"; }
				{ name = "*.ppt" ; use = "libreoffice"; }
				{ name = "*.pptx"; use = "libreoffice"; }
				{ name = "*.xls" ; use = "libreoffice"; }
				{ name = "*.xlsx"; use = "libreoffice"; }

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
				{ on = ["?"]; run = "help";  desc = "Open help"; }
				{ on = ["Q"]; run = "quit";  desc = "Quit"; }
				{ on = ["q"]; run = "close"; desc = "Close current tab or quit if last"; }
				{ on = ["<Esc>"]; run = ["escape" "unyank"]; desc = "Exit visual mode, clear selected, or cancel search"; }
				{ on = ["<C-d>"]; run = ''shell "$SHELL" --block --confirm''; desc = "Open shell here"; }
				{ on = ["<C-j>"]; run = "arrow  50%"; desc = "Move cursor half page down"; }
				{ on = ["<C-k>"]; run = "arrow -50%"; desc = "Move cursor half page up"; }
				{ on = ["J"]; run = "tab_switch -1 --relative"; desc = "Switch to the previous tab"; }
				{ on = ["K"]; run = "tab_switch  1 --relative"; desc = "Switch to the next tab"; }
				{ on = ["u"]; run = "shell 'dua i' --block --confirm"; desc = "Disk Usage (dua i)"; }
				#{ on = [ "m" "c" ]; run = "linemode ctime"; desc = "Set linemode to ctime"; }

				{ on = ["c" "c"]; run = ''shell 'filename="$1" && wl-copy "file://$filename" --type text/uri-list' --confirm''; desc = "Copy file using URI (file://)"; }
				{ on = ["c" "a"]; run = "copy path";             desc = "Copy Absolute path"; }
				{ on = ["c" "d"]; run = "copy dirname";          desc = "Copy the path of the parent Directory"; }
				{ on = ["c" "e"]; run = "copy name_without_ext"; desc = "Copy the name of the file without the Extension"; }
				{ on = ["c" "n"]; run = "copy filename";         desc = "Copy the Name of the file"; }

				{ on = ["," "s"]; run = "sort size --dir-first --reverse"; desc = "Sort by size"; }
				{ on = ["," "S"]; run = "sort size --dir-first";           desc = "Sort by size (reverse)"; }
				{ on = ["," "m"]; run = "sort modified --dir-first --reverse"; desc = "Sort by modified time (reverse)"; }
				{ on = ["," "M"]; run = "sort modified --dir-first";           desc = "Sort by modified time"; }

				# GOTOs:
				# basic:
				{ on = ["g" "/"]; run = "cd /"; }
				#{ on = ["g" ""]; run = "cd /tmp"; }
				{ on = ["g" "h"]; run = "cd ~"; }
				# hidden:
				{ on = ["g" "."]; run = "cd ~/.config"; }
				{ on = ["g" "M"]; run = "cd ~/.config/home-manager"; }
				{ on = ["g" "T"]; run = "cd ~/.local/share/Trash/files"; }
				# home:
				{ on = ["g" "c"]; run = "cd ~/projects"; }
				{ on = ["g" "C" "t"]; run = "cd ~/projects/touhou_unfathomable_calamity"; }
				{ on = ["g" "o"]; run = "cd ~/Documents"; }
				{ on = ["g" "d"]; run = "cd ~/Downloads"; }
				{ on = ["g" "t"]; run = "cd '~/Downloads/Telegram Desktop'"; }
				{ on = ["g" "r"]; run = "cd ~/Dropbox"; }
				{ on = ["g" "u"]; run = "cd ~/Dropbox/University/Mast4"; }
				{ on = ["g" "i"]; run = "cd ~/Dropbox/University/Master_Thesis"; }
				{ on = ["g" "m"]; run = "cd ~/Music"; }
				{ on = ["g" "p"]; run = "cd ~/Pictures"; }
				{ on = ["g" "s"]; run = "cd ~/Pictures/Screenshots/2024"; }
				{ on = ["g" "v"]; run = "cd ~/Videos"; }
				# games:
				{ on = ["g" "a" "3"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/374320/pfx/drive_c/users/steamuser/AppData/Roaming/DarkSoulsIII"; }
				{ on = ["g" "a" "c"]; run = "cd ~/.local/share/Celeste/Saves"; }
				{ on = ["g" "a" "e"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/1245620/pfx/drive_c/users/steamuser/AppData/Roaming/EldenRing"; }
				{ on = ["g" "a" "t" "h" "6"]; run = "cd '~/Games/Touhou/Touhou 6 - The Embodiment of Scarlet Devil'"; }
				{ on = ["g" "a" "t" "h" "7"]; run = "cd '~/Games/Touhou/Touhou 7 - Perfect Cherry Blossom'"; }
				{ on = ["g" "a" "t" "h" "8"]; run = "cd '~/Games/Touhou/Touhou 8 - Imperishable Night'"; }
				#{ on = ["g" "a" "t" "h" "9"]; run = "cd cd ~/.local/share/Steam/steamapps/common/th9"; }
				{ on = ["g" "a" "t" "h" "1" "0"]; run = "cd ~/.local/share/Steam/steamapps/common/th10"; }
				{ on = ["g" "a" "t" "h" "1" "1"]; run = "cd ~/.local/share/Steam/steamapps/common/th11"; }
				{ on = ["g" "a" "t" "h" "1" "2"]; run = "cd ~/.local/share/Steam/steamapps/common/th12"; }
				{ on = ["g" "a" "t" "h" "1" "3"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/1043230/pfx/drive_c/users/steamuser/AppData/Roaming/ShanghaiAlice/th13"; }
				{ on = ["g" "a" "t" "h" "1" "4"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/1043240/pfx/drive_c/users/steamuser/AppData/Roaming/ShanghaiAlice/th14"; }
				{ on = ["g" "a" "t" "h" "1" "5"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/937580/pfx/drive_c/users/steamuser/AppData/Roaming/ShanghaiAlice/th15"; }
				{ on = ["g" "a" "t" "h" "1" "6"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/745880/pfx/drive_c/users/steamuser/AppData/Roaming/ShanghaiAlice/th16"; }
				{ on = ["g" "a" "t" "h" "1" "7"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/1079160/pfx/drive_c/users/steamuser/AppData/Roaming/ShanghaiAlice/th17"; }
				{ on = ["g" "a" "t" "h" "1" "8"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/1566410/pfx/drive_c/users/steamuser/AppData/Roaming/ShanghaiAlice/th18"; }
				#{ on = ["g" "a" "t" "h" "1" "9"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/2400340/pfx/drive_c/users/steamuser/AppData/Roaming/ShanghaiAlice/th19"; }
				{ on = ["g" "a" "t" "r"]; run = "cd ~/.local/share/Steam/steamapps/compatdata/11020/pfx/drive_c/users/steamuser/Documents/TrackMania/Tracks/Replays"; }
				{ on = ["g" "a" "t" "s"]; run = "cd '~/.local/share/Steam/steamapps/common/TrackMania Nations Forever/GameData/Painter/Stickers'"; }
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
				{ name = "*.tex"; text = ""; }
			];
		};
	} // (
		import ./yazi-theme-gruvbox.nix
	);
}
