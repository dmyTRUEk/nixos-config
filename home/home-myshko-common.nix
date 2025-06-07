{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	# TODO?: make `enable`/`enabled` function that sets enable=true.

	imports = [
		inputs.nix-colors.homeManagerModules.default

		# You can also split up your configuration and import pieces of it here:
		# ./nvim.nix
	];

	home = {
		# TODO: refactor to not write username manually?
		username = "myshko";
		homeDirectory = "/home/myshko";
	};

	home.file =
	let
		inherit (config.lib.file) mkOutOfStoreSymlink;
		dotfiles_path = "${config.home.homeDirectory}/.config/home-manager/home/dotfiles";
		config_path = "${config.home.homeDirectory}/.config"; # TODO(refactor)?: use /.
		setup_simple_symlinks = builtins.foldl' (acc: elem: acc // {
			"${config_path}/${elem}".source = mkOutOfStoreSymlink "${dotfiles_path}/${elem}";
		}) {};
	in (
		# let tmp = # for dbg
		setup_simple_symlinks [
			"gammastep"
			"kitty"
			"nvim"
			"sway"
			"swayimg"
			"swaylock"
			"waybar"
			"zathura"
		]
		# // setup_complex_symlinks {}
		// {
			"${config.home.homeDirectory}/.xkb/symbols".source = mkOutOfStoreSymlink "${dotfiles_path}/sway/keyboard-layouts";
		}
		# ; in builtins.trace tmp tmp # for dbg
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

	# colorSchemes: https://github.com/tinted-theming/schemes
	colorScheme =
	let
		colorSchemes = inputs.nix-colors.colorSchemes;
		# // (
		# 	let cs = import ./colorscheme-gruvbox-my.nix; in { "${cs.slug}" = cs; }
		# );
	in
		colorSchemes.
		#gruvbox-dark-medium
		#gruvbox-dark-soft
		gruvbox-dark-pale
		#gruvbox-material-dark-medium
		#gruvbox-material-dark-soft
		#gruvbox-material-dark-hard
		# gruvbox-by-dmytruek
		#onedark
		#tokyo-night-terminal-dark
		#everforest
	;

	wayland.windowManager.sway = {
		#enable = true; # dont `.enable` bc of dotfiles symlinks
		wrapperFeatures.gtk = true;
		#programs.sway.extraConfig = ''
		#	exec_always ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
		#'';
	};

	programs = {
		# IMPORTANT!!!
		# - DO NOT `.enable` programs that have dotfiles symlinks
		# IMPORTANT!!!

		git = {
			enable = true;
			userName = "dmyTRUEk";
			userEmail = "25669613+dmyTRUEk@users.noreply.github.com";
			extraConfig = {
				init.defaultBranch = "main";
				#core.askPass = "";
				push.autoSetupRemote = true;
				merge.tool = "nvimdiff";
			};
		};
	};

	home.packages = with pkgs; [ # PKGS
		dropbox
	];

	# Nicely reload system units when changing configs
	#systemd.user.startServices = "sd-switch"; # sd = systemd

	# use Wayland where possible (electron)
	# TODO: enable?
	#environment.variables.NIXOS_OZONE_WL = "1";

	services = {
		mako = import ./programs/mako.nix { inherit config; };
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
			# TODO: make yazi open "folders"
			associations.added = {
				"x-scheme-handler/tg" = "org.telegram.desktop.desktop";
				"application/pdf" = "org.pwmt.zathura.desktop";
			};
			defaultApplications = {
				"x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
				"application/pdf" = [ "org.pwmt.zathura.desktop" ];
				"text/plain" = [ "neovim-in-alacritty.desktop" ];
				#"application/vnd.oasis.opendocument.text" = [ "" ] # TODO
			};
		};
	};
}
