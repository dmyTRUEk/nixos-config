{
	inputs,
	lib,
	config,
	pkgs,
	...
}: {
	# TODO?: make `enable`/`enabled` function that sets enable=true.

	imports = [];

	home = {
		# TODO: refactor to not write username manually?
		username = "myshko";
		homeDirectory = "/home/myshko"; # remove bc not needed?
	};

	home.file =
	let
		inherit (builtins) foldl' elemAt;
		inherit (config.lib.file) mkOutOfStoreSymlink;
		config_path = "${config.home.homeDirectory}/.config"; # TODO(refactor)?: use /.
		dotfiles_path = "${config.home.homeDirectory}/.config/home-manager/home/dotfiles";
		setup_simple_symlinks = foldl' (acc: elem: acc // {
			"${config_path}/${elem}".source = mkOutOfStoreSymlink "${dotfiles_path}/${elem}";
		}) {};
		setup_complex_symlinks = foldl' (acc: elem_pair: acc // {
			"${elemAt elem_pair 0}".source = mkOutOfStoreSymlink "${elemAt elem_pair 1}";
		}) {};
	in (
		#let tmp = # for dbg
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
		// setup_complex_symlinks [
			[ "${config.home.homeDirectory}/.xkb/symbols" "${dotfiles_path}/sway/keyboard-layouts" ]
			#[ "${config.home.homeDirectory}/mnt" "/run/media/${config.home.username}" ]
		]
		#//
		#{
		#	#"${config_path}/anyrun/style.css".source = lib.mkForce (mkOutOfStoreSymlink "${dotfiles_path}/../programs/anyrun-style.css");
		#}
		#; in builtins.trace tmp tmp # for dbg
	);

	programs = {
		# IMPORTANT!!!
		# - DO NOT `.enable` programs that have dotfiles symlinks
		# IMPORTANT!!!

		git = {
			enable = true;
			settings = {
				user.name = "dmyTRUEk";
				user.email = "25669613+dmyTRUEk@users.noreply.github.com";
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
