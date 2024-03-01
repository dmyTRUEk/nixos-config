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
		# TODO: refactor to not write username manually
		username = "myshko";
		homeDirectory = "/home/myshko";
	};

	home.file =
	let
		inherit (config.lib.file) mkOutOfStoreSymlink;
		dotfiles_path = ./dotfiles;
		config_path = "${config.home.homeDirectory}/.config";
	in {
		"${config_path}/nvim/init.lua".source = mkOutOfStoreSymlink "${dotfiles_path}/nvim/init.lua";
		"${config_path}/sway".source = mkOutOfStoreSymlink "${dotfiles_path}/sway";
		"${config_path}/waybar".source = mkOutOfStoreSymlink "${dotfiles_path}/waybar";
	};

	programs = {
		#home-manager.enable = true; # enable to self-host?
		alacritty = {
			enable = true;
			settings = builtins.fromTOML (builtins.readFile ./dotfiles/alacritty/alacritty.toml);
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
		};
		zsh = {
			enable = true;
			enableAutosuggestions = true;
			syntaxHighlighting.enable = true;
			oh-my-zsh = {
				enable = true;
				theme = "robbyrussell";
				plugins = [
					"history-substring-search"
					"colored-man-pages"
					# "zsh-autosuggestions"
					# "zsh-syntax-highlighting"
					"rust"
				];
			};
			shellAliases = {
				# neovim
				neovim = "nvim";
				n = "nvim";
				"n." = "nvim .";
				nd = "nvim -d";

				# lsd
				l = "lsd";
				la = "lsd -A";
				ll = "lsd -Al";

				mkdir = "mkdir -p";
				cl = "clear"; # TODO

				cdd = "cd ~/.config/home-manager";
				cdc = "cd ~/.config/home-manager";
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

				whatismyip = "curl -s https://icanhazip.com";
				whatismylocalip = "ip addr | grep -oE '192\.168\.[0-9]{1,3}\.[0-9]{1,3}' | head -n 1";

				dv = "yt-dlp";
				dm = "yt-dlp -x --audio-format mp3 --embed-thumbnail --embed-metadata";
				dm_without_covers = "yt-dlp -x --audio-format mp3 --embed-metadata";

				nixi = "nix repl"; # nix interactive
				nic = "nvim ~/.config/home-manager/nixos/configuration.nix";
				nih = "nvim ~/.config/home-manager/home-manager/home.nix";
				nif = "nvim ~/.config/home-manager/flake.nix";
			};
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
				color_theme = "gruvbox_dark_v2";
				vim_keys = true;
				update_ms = 100;
				proc_sorting = "memory";
				proc_tree = true;
			};
		};
		ripgrep.enable = true;
		direnv = {
			enable = true;
			enableZshIntegration = true;
		};
	};

	wayland.windowManager.sway = {
		enable = true;
		#extraConfig = builtins.readFile ./dotfiles/sway/config;
	};

	home.packages = with pkgs; [
		tree
		neofetch
		pulseaudio  # provides pactl, to change volume by fn keys
		pavucontrol # gui to control volume
		playerctl
		#light # TODO(fix): grant access to "video" group?
		gammastep
		mako
		kitty
		btop
		wl-clipboard
		grim
		jq
		slurp
		telegram-desktop
		ranger
		(python3.withPackages (python-pkgs: [
			python-pkgs.i3ipc
		]))
		killall
		# steam # the meme
		gcc
		lsd # modern ls (rust btw)
		hyperfine # (rust btw)
		libnotify # for notify-send

		# LSP:
		lua-language-server
		nil # nix language server (rust btw)
		ruff-lsp

		# fonts:
		jetbrains-mono # pretty ok monospace font
		# for icons
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		#font-awesome # for icons
		source-han-serif
		source-han-sans
		corefonts  # Microsoft's TrueType core fonts for the Web
		vistafonts # Some TrueType fonts from Microsoft Windows Vista (Calibri, Cambria, Candara, Consolas, Constantia, Corbel)
	];

	fonts.fontconfig.enable = true;

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch"; # sd = systemd

	# use Wayland where possible (electron)
	# TODO: enable?
	#environment.variables.NIXOS_OZONE_WL = "1";

	# TODO: enable?
	#xdg.portal = {
	#	enable = true;
	#	extraPortals = [ 
	#		pkgs.xdg-desktop-portal-gtk 
	#	];
	#};
}
