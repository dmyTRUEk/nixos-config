# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
	inputs,
	lib,
	config,
	pkgs,
	nixla,
	# nil,
	...
}: {
	programs = {
		# IMPORTANT!!!
		# - DO NOT `.enable` programs that have dotfiles symlinks
		# IMPORTANT!!!

		neovim = {
			enable = true;
			defaultEditor = true;
			#extraLuaConfig = builtins.readFile ./dotfiles/nvim/init.lua;
		};
		git = {
			enable = true;
			#extraConfig = {
			#	credential.helper = "${
			#		pkgs.git.override { withLibsecret = true; }
			#	}/bin/git-credential-libsecret";
			#};
		};
		zsh.enable = true; # only for rare tests
		fish = import ./programs/fish.nix { inherit lib; };
		alacritty = import ./programs/alacritty.nix { inherit config; }; # (rust btw)
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
				theme_background = false;
				proc_sorting = "memory";
				proc_per_core = true;
				update_ms = 100;
				#proc_tree = true;
			};
		};
		jq.enable = true;
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
		#texlive = {
		#	enable = true;
		#	packageSet = pkgs.texliveFull;
		#};
		obs-studio.enable = true;
		anyrun = import ./programs/anyrun.nix { inherit inputs pkgs; }; # (rust btw)
		skim.enable = true; # (rust btw)
		fd = { # (rust btw)
			enable = true;
			hidden = true; # search hidden files and directories
		};
		bottom = { # (rust btw)
			enable = true;
			#settings = {};
		};
		fastfetch.enable = true;
		eza = { # (rust btw)
			enable = true;
			enableFishIntegration = true;
			icons = "auto";
			extraOptions = [
				"--group-directories-first"
			];
		};
		#mangohud.enable = true;
	};

	home.packages = with pkgs; [ # PKGS
		# INFO:
		lshw # ls hardware
		glxinfo # gpu info
		vulkan-tools # for vulkaninfo, gpu info
		wev # wayland event viewer
		wayland-utils

		# "LIBS":
		pulseaudio # provides pactl, to change volume by fn keys # TODO: replace by `wpctl`
		playerctl
		gammastep
		wl-clipboard
		grim
		slurp
		libnotify # for notify-send
		polkit_gnome
		gnome-keyring

		# CLI:
		tree
		killall
		dua # disk usage (rust btw)
		hyperfine # (rust btw)
		tokei # (rust btw)
		zip
		unzip
		p7zip
		unrar
		texliveFull
		ffmpeg
		nix-tree
		nvd
		curlftpfs
		wtype

		# CLI fun:
		fortune
		#cowsay
		#lolcat -> ur0/lolcat (rust btw)
		cmatrix
		cbonsai

		# GUI+CLI:
		imagemagick
		# ventoy

		# GUI:
		waybar
		kitty
		pavucontrol # gui to control volume
		telegram-desktop
		swayimg
		krita
		gnome-boxes
		libreoffice
		hunspell
		hunspellDicts.en_US-large # for libreoffice ENG spellcheck
		hunspellDicts.uk_UA       # for libreoffice UKR spellcheck
		zathura
		kdePackages.kdenlive
		vlc
		transmission_4-gtk
		zoom-us
		discord
		kdePackages.gwenview
		helvum
		audacity
		amberol # gnome music player
		element-desktop

		# LANGS:
		rustup # rust btw
		#cargo-cross # rust btw
		(python3.withPackages (python-pkgs: with python-pkgs; [
			i3ipc # for ANWS
			numpy
			matplotlib
			pipe
			scipy
		]))
		gcc
		lean4
		android-studio
		android-tools # for `adb`
		nixla.packages.${system}.nixla
		nixla.packages.${system}.nixla-nix
		nixla.packages.${system}.nixla-json

		# LSP:
		lua-language-server # lua
		# nil.packages.${system}.nil # nix (rust btw)
		pyright # python
		#ruff-lsp # python # TODO: setup it for lints, cs it's fast (rust btw)

		# cursors:
		#vimix-cursors
		#vimix-cursor-theme
		# TODO: kde/breeze cursor

		# libs:
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "24.11"; # Did you read the comment?
}
