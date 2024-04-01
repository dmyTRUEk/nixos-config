# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	# TODO?: make `enable`/`enabled` function that sets enable=true.

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "23.11";

	# You can import other home-manager modules here
	imports = [
		# If you want to use home-manager modules from other flakes (such as nix-colors):
		# inputs.nix-colors.homeManagerModule

		# You can also split up your configuration and import pieces of it here:
		# ./nvim.nix

		#inputs.anyrun.homeManagerModules#.default
	];

	nixpkgs = {
		# You can add overlays here
		overlays = [
			# If you want to use overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#   hi = final.hello.overrideAttrs (oldAttrs: {
			#     patches = [ ./change-hello-to-hi.patch ];
			#   });
			# })
		];
		# Configure your nixpkgs instance
		config = {
			# Disable if you don't want unfree packages
			allowUnfree = true;
			# Workaround for https://github.com/nix-community/home-manager/issues/2942
			allowUnfreePredicate = _: true;
		};
	};

	home = {
		# TODO: refactor to not write username manually?
		username = "myshko";
		homeDirectory = "/home/myshko";
	};

	home.file =
	let
		inherit (config.lib.file) mkOutOfStoreSymlink;
		dotfiles_path = "${config.home.homeDirectory}/.config/home-manager/home-manager/dotfiles";
		config_path = "${config.home.homeDirectory}/.config"; # TODO(refactor): use /.
		setup_simple_symlinks = names: lib.mkMerge (builtins.map (name: {
			"${config_path}/${name}".source = mkOutOfStoreSymlink "${dotfiles_path}/${name}";
		}) names);
		#setup_complex_symlinks = lib.mapAttrs' (name: value: lib.nameValuePair
		#	("${config_path}/${name}".source)
		#	(mkOutOfStoreSymlink "${dotfiles_path}/${value}")
		#);
	in (
		setup_simple_symlinks [
			"alacritty"
			#"anyrun"
			"gammastep"
			"imv"
			"kitty"
			"mako"
			"nvim"
			"ranger"
			"sway"
			"swayimg"
			"swaylock"
			"waybar"
			"zathura"
		]
		#//
		#setup_complex_symlinks {}
	);

	home.pointerCursor =
		let
		getFrom = url: hash: name: {
			inherit name;
			gtk.enable = true;
			x11.enable = true;
			size = 48;
			package =
				pkgs.runCommand "moveUp" {} ''
				mkdir -p $out/share/icons
				ln -s ${pkgs.fetchzip {
					inherit url hash;
				}} $out/share/icons/${name}
			'';
		};
	in
		getFrom
		"https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.0/BreezeX-Black.tar.gz"
		"sha256-5su79uUG9HLeAqXDUJa/VhpbYyy9gFj/VdtRPY0yUL4="
		"BreezeX-Black";

	programs = {
		#home-manager.enable = true; # enable to self-host?
		alacritty = {
			enable = true;
			#settings = builtins.fromTOML (builtins.readFile ./dotfiles/alacritty/alacritty.toml);
		};
		neovim = {
			enable = true;
			defaultEditor = true;
			#extraLuaConfig = builtins.readFile ./dotfiles/nvim/init.lua;
		};
		git = {
			enable = true;
			userName = "dmyTRUEk";
			userEmail = "25669613+dmyTRUEk@users.noreply.github.com";
			#extraConfig = {
			#	credential.helper = "${
			#		pkgs.git.override { withLibsecret = true; }
			#	}/bin/git-credential-libsecret";
			#};
		};
		zsh.enable = true;
		fish = {
			enable = true;
			shellAliases = {
				# neovim
				neovim = "nvim";
				n = "nvim";
				"n." = "nvim .";
				nd = "nvim -d";
				nr = "nvim -R"; # open in read-only mode

				# lsd
				l = "lsd";
				la = "lsd -A";
				ll = "lsd -Al";

				mkdir = "mkdir -p";
				cl = "clear ; git status || clear";

				#"-" = "cd -";
				cdd = "cd ~/.config/home-manager";
				".." = "cd ..";
				"..." = "cd ../..";
				"..2" = "cd ../..";
				"...." = "cd ../../..";
				"..3" = "cd ../../..";
				"..4" = "cd ../../../..";
				"..5" = "cd ../../../../..";

				please = "sudo";
				grep = "grep -i --color";
				whereami = "pwd";
				findtextinfiles = "grep -rn";
				duai = "dua i";

				# git
				g = "git";
				ga = "git add";
				"ga." = "git add .";
				gap = "git add --patch";
				"gap." = "git add --patch .";
				gb = "git branch";
				gc = "git commit";
				gch = "git checkout";
				gchb = "git checkout -b";
				gcl = "git clone";
				gcm = "git commit -m";
				gd = "git diff";
				"gd." = "git diff .";
				gds = "git diff --staged";
				"gds." = "git diff --staged .";
				gf = "git fetch";
				gfo = "git fetch origin";
				gl = "git log --oneline --decorate --graph";
				gm = "git merge";
				gmt = "git mergetool";
				gpull = "git pull";
				gpush = "git push";
				grs = "git restore --staged";
				"grs." = "git restore --staged .";
				grsp = "git restore --staged --patch";
				"grsp." = "git restore --staged --patch .";
				gs = "git status -u --find-renames=1";
				gss = "git status";
				gstash = "git stash push";
				gstashp = "git stash pop";

				whatismyip = "curl -s https://icanhazip.com";
				whatismylocalip = "ip addr | grep -oE '192\.168\.[0-9]{1,3}\.[0-9]{1,3}' | head -n 1";

				dv = "yt-dlp";
				dm = "yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail";
				dm_without_covers = "yt-dlp -x --audio-format mp3 --embed-metadata";
				#random_hash = "";

				nixi = "nix repl"; # nix interactive
				nx  = "nvim ~/.config/home-manager/";
				nic = "nvim ~/.config/home-manager/nixos/configuration.nix";
				nih = "nvim ~/.config/home-manager/home-manager/home.nix";
				nif = "nvim ~/.config/home-manager/flake.nix";
				#nixos-gc-5d = "nix-collect-garbage --delete-older-than 5d && sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 5d && sudo nixos-rebuild switch --flake ~/.config/home-manager/";
				nixos-gc-5d = "nix-collect-garbage --delete-older-than 5d && sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 5d";
				# TODO: two functions that accept how much delete: time (5d), number (10)
				# TODO: use `nix store optimise` at the end
				# TODO: use `nixos-rebuild switch` to "clean up" "boot options"

				nn  = "nvim ~/.config/home-manager/home-manager/dotfiles/nvim/init.lua";
				ns  = "nvim ~/.config/home-manager/home-manager/dotfiles/sway/config";
				nss = "nvim ~/.config/home-manager/home-manager/dotfiles/sway/scripts/";
				nw  = "nvim ~/.config/home-manager/home-manager/dotfiles/waybar/config";
				nanws="nvim ~/.config/home-manager/home-manager/dotfiles/sway/scripts/autoname-workspaces.py";
				#nf = "nvim ~/.config/home-manager/home-manager/dotfiles/fish";
				nfh = "nvim ~/.local/share/fish/fish_history";

				nre = "nvim README.md";

				# rust related:
				nc = "nvim Cargo.toml";
				ncl = "nvim Cargo.lock";

				cc = "cargo clean";
				ct = "cargo test";
				ctr = "cargo test --release";
				ctrn = "RUSTFLAGS='-C target-cpu=native' cargo test --release";

				cr = "cargo run";
				crr = "cargo run --release";
				crrn = "RUSTFLAGS='-C target-cpu=native' cargo run --release";
				ctcr = "cargo test && cargo run";
				ctcrr = "cargo test && cargo run --release";
				ctcrrn = "cargo test && RUSTFLAGS='-C target-cpu=native' cargo run --release";

				cb = "cargo build";
				cbr = "cargo build --release";
				cbrn = "RUSTFLAGS='-C target-cpu=native' cargo build --release";
				ctcb = "cargo test && cargo build";
				ctcbr = "cargo test && cargo build --release";
				ctcbrn = "cargo test && RUSTFLAGS='-C target-cpu=native' cargo build --release";

				time-elapsed = "command time -f 'time elapsed: %E'";

				fumo = "gensoquote | fumosay | lolcat";
			};
			shellInit = ''
				# low priority first, high -- last
				fish_add_path -m ~/.cargo/bin
				fish_add_path -m ~/.local/bin
				function fish_greeting
				end
				#function random_hash
				#	local default_len=6
				#	local hash_len=$default_len
				#	if [[ -n $1 ]]; then
				#		local hash_len=$1
				#	fi
				#	echo $(date +%s%N | sha512sum | cut -c -$hash_len)
				#end
				set __fish_git_prompt_showdirtystate true
				set __fish_git_prompt_showcolorhints true
				set __fish_git_prompt_describe_style branch
				set __fish_git_prompt_showstashstate true
				#function fumo
				#	gensoquote -c $1 | fumosay -f $1 | lolcat
				#end
			'';
		};
		waybar.enable = true;
		firefox = {
			enable = true;
			# TODO: enable somehow?
			#profiles."default".settings = {
			#	"browser.tabs.inTitlebar" = 0;
			#};
		};
		btop = {
			enable = true;
			settings = {
				vim_keys = true;
				color_theme = "gruvbox_dark_v2";
				proc_sorting = "memory";
				proc_per_core = true;
				update_ms = 100;
				#proc_tree = true;
			};
		};
		ripgrep.enable = true;
		direnv.enable = true;
		nix-index = {
			enable = true;
			enableFishIntegration = true;
		};
		#zathura.enable = true; # dont `.enable` bc of dotfiles symlinks
		yazi.enable = true;
		yt-dlp.enable = true;
		#texlive.enable = true;
		obs-studio.enable = true;
		#anyrun = {
		#	enable = true;
		#	config = {
		#		plugins = [
		#			# An array of all the plugins you want, which either can be paths to the .so files, or their packages
		#			#inputs.anyrun.packages.${pkgs.system}.applications
		#			#./some_plugin.so
		#			#"${inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins}/lib/kidex"
		#		];
		#		#width = { fraction = 0.3; };
		#		#position = "top";
		#		#verticalOffset = { absolute = 0; };
		#		#hideIcons = false;
		#		#ignoreExclusiveZones = false;
		#		#layer = "overlay";
		#		#hidePluginInfo = false;
		#		#closeOnClick = false;
		#		#showResultsImmediately = false;
		#		#maxEntries = null;
		#	};
		#	#extraCss = ''
		#	#	.some_class {
		#	#		background: red;
		#	#	}
		#	#'';

		#	#extraConfigFiles."some-plugin.ron".text = ''
		#	#	Config(
		#	#		// for any other plugin
		#	#		// this file will be put in ~/.config/anyrun/some-plugin.ron
		#	#		// refer to docs of xdg.configFile for available options
		#	#	)
		#	#'';
		#};
	};

	wayland.windowManager.sway = {
		#enable = true; # dont `.enable` bc of dotfiles symlinks
		wrapperFeatures.gtk = true;
	};

	home.packages = with pkgs; [
		# "LIBS":
		pulseaudio # provides pactl, to change volume by fn keys
		playerctl
		gammastep
		mako
		#light # TODO(fix): grant access to "video" group?
		wl-clipboard
		grim
		slurp
		libnotify # for notify-send
		polkit_gnome
		gnome.gnome-keyring

		# CLI:
		tree
		neofetch
		btop
		jq
		ranger
		(python3.withPackages (python-pkgs: with python-pkgs; [
			i3ipc # for ANWS
			numpy
			matplotlib
		]))
		killall
		gcc
		lsd # modern ls (rust btw)
		dua # disk usage (rust btw)
		hyperfine # (rust btw)
		skim # (rust btw)
		rustup # rust btw
		lshw # ls hardware
		glxinfo # gpu info
		fortune
		#cowsay
		#lolcat -> ur0/lolcat (rust btw)
		tokei # (rust btw)
		zip
		unzip
		p7zip
		texliveFull

		# GUI:
		pavucontrol # gui to control volume
		kitty
		telegram-desktop
		krita
		swayimg
		gnome.gnome-boxes
		libreoffice
		zathura # here instead of `.enable` bc of dotfiles symlinks
		kdenlive
		vlc
		dropbox
		transmission-gtk
		zoom-us
		discord

		# LSP:
		lua-language-server # lua
		nil # nix (rust btw)
		pyright # python
		#ruff-lsp # python # TODO: setup it for lints

		# fonts:
		jetbrains-mono # pretty ok monospace font
		# for icons
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		#font-awesome # for icons
		source-han-serif
		source-han-sans
		corefonts  # Microsoft's TrueType core fonts for the Web
		vistafonts # Some TrueType fonts from Microsoft Windows Vista (Calibri, Cambria, Candara, Consolas, Constantia, Corbel)

		# cursors:
		#vimix-cursors
		#vimix-cursor-theme
		# TODO: kde/breeze cursor
	];

	fonts.fontconfig.enable = true;

	# Nicely reload system units when changing configs
	#systemd.user.startServices = "sd-switch"; # sd = systemd

	# use Wayland where possible (electron)
	# TODO: enable?
	#environment.variables.NIXOS_OZONE_WL = "1";

	services = {
		gnome-keyring.enable = true;
		#dropbox.enable = true; # somewhy this doesn't work, so just pkg instead
	};

	xdg = {
		enable = true;
		mime.enable = true;

		desktopEntries = {
			neovim-in-alacritty = {
				name = "NeoVim (in Alacritty)";
				comment = "Terminal text editor launched in Alacritty terminal emulator";
				#genericName = "";
				exec = "alacritty -e nvim";
				mimeType = [ "text/plain" ];
				categories = [ "Utility" "TextEditor" ];
				terminal = false;
				icon = "terminal";
			};
			ranger-in-kitty = {
				name = "Ranger (in Kitty)";
				comment = "Terminal file manager launched in Kitty terminal emulator";
				#genericName = "";
				exec = "kitty env RANGER_LOAD_DEFAULT_RC=false ranger %U";
				mimeType = [ "inode/directory" ];
				categories = [ "System" "FileTools" "FileManager" "Utility" "Core" ];
				terminal = false;
				icon = "user-desktop";
			};
		};

		mimeApps = {
			enable = true;
			associations.added = {
				"x-scheme-handler/tg" = "org.telegram.desktop.desktop";
				"application/pdf" = "org.pwmt.zathura.desktop";
			};
			defaultApplications = {
				"x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
				"application/pdf" = [ "org.pwmt.zathura.desktop" ];
				"text/plain" = [ "neovim-in-alacritty.desktop" ];
			};
		};
	};
}
