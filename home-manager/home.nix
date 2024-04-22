# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
	inputs,
	lib,
	config,
	pkgs,
	pkgs_2024-04-11_1042fd8,
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
			"gammastep"
			"kitty"
			"mako"
			"nvim"
			"sway"
			"swayimg"
			#"swaylock"
			"waybar"
			"zathura"
		]
		#//
		#setup_complex_symlinks {}
	);

	home.pointerCursor =
	let
		getCursorFrom = url: hash: name: {
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
		getCursorFrom
		"https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.0/BreezeX-Black.tar.gz"
		"sha256-5su79uUG9HLeAqXDUJa/VhpbYyy9gFj/VdtRPY0yUL4="
		"BreezeX-Black";

	programs = {
		# IMPORTANT!!!
		# - DO NOT `.enable` programs that have dotfiles symlinks
		# IMPORTANT!!!

		#home-manager.enable = true; # enable to self-host?
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
		zsh.enable = true; # only for rare tests
		fish = import ./programs/fish.nix { inherit lib; };
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
		ripgrep.enable = true; # (rust btw)
		direnv = {
			enable = true;
			#enableFishIntegration = true; # it's by default
		};
		nix-index = {
			enable = true;
			enableFishIntegration = true;
		};
		yazi = import ./programs/yazi.nix; # (rust btw)
		yt-dlp.enable = true;
		#texlive.enable = true;
		obs-studio.enable = true;
		anyrun = import ./programs/anyrun.nix { inherit inputs pkgs; }; # (rust btw)
		fd = { # (rust btw)
			enable = true;
			hidden = true; # search hidden files and directories
		};
		bottom = {
			enable = true;
			#settings = {};
		};
	};

	wayland.windowManager.sway = {
		#enable = true; # dont `.enable` bc of dotfiles symlinks
		wrapperFeatures.gtk = true;
		#programs.sway.extraConfig = ''
		#	exec_always ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
		#'';
	};

	home.packages = with pkgs; [
		# INFO:
		lshw # ls hardware
		glxinfo # gpu info
		vulkan-tools # for vulkaninfo, gpu info
		wev # wayland event viewer
		wayland-utils

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
		jq
		killall
		lsd # modern ls (rust btw)
		dua # disk usage (rust btw)
		hyperfine # (rust btw)
		skim # (rust btw)
		fortune
		#cowsay
		#lolcat -> ur0/lolcat (rust btw)
		tokei # (rust btw)
		zip
		unzip
		p7zip
		unrar
		texliveFull
		ffmpeg
		nix-tree
		nvd

		# LANGS:
		rustup # rust btw
		#cargo-cross # rust btw
		(python3.withPackages (python-pkgs: with python-pkgs; [
			i3ipc # for ANWS
			numpy
			matplotlib
		]))
		gcc
		#alsa-lib pkg-config # for bevy (rust btw)

		# GUI:
		alacritty # (rust btw)
		waybar
		kitty
		pavucontrol # gui to control volume
		pkgs_2024-04-11_1042fd8.telegram-desktop
		swayimg
		krita
		gnome.gnome-boxes
		libreoffice
		zathura
		kdenlive
		vlc
		dropbox
		transmission-gtk
		zoom-us
		discord
		blender

		# GUI+CLI:
		imagemagick

		# LSP:
		lua-language-server # lua
		nil # nix (rust btw)
		pyright # python
		#ruff-lsp # python # TODO: setup it for lints, cs it's fast (rust btw)

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
			neovim-in-alacritty = import ./desktop-entries/neovim-in-alacritty.nix;
			yazi-in-kitty = import ./desktop-entries/yazi-in-kitty.nix;
		};

		mimeApps = {
			enable = true;
			# TODO: test if yazi opens "folders"
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
