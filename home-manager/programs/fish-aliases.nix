# programs.fish.shellAliases =
{
	# neovim
	neovim = "nvim";
	n = "nvim";
	"n." = "nvim .";
	nd = "nvim -d";
	nr = "nvim -R"; # open in read-only mode
	nhoriz = "nvim -o"; # split with horizontal divider
	nvert  = "nvim -O"; # split with vertical divider

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
	gpush-force = "git push --force-with-lease";
	grs = "git restore --staged";
	"grs." = "git restore --staged .";
	grsp = "git restore --staged --patch";
	"grsp." = "git restore --staged --patch .";
	gs = "git status -u --find-renames=1";
	gss = "git status";
	gstash = "git stash push --keep-index";
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

	# src: https://github.com/cross-rs/cross/blob/6d097fb548ec121c2a0faf1c1d8ef4ca360d6750/docs/environment_variables.md?plain=1#L15
	crosss = "NIX_STORE=/nix/store cross";

	interactive_python = "python -i ~/.config/home-manager/home-manager/files/init_interactive_python.py";
	ipy = "interactive_python";

	time-elapsed = "command time -f 'time elapsed: %E'";

	yy = "yazi_with_cwd_memory";

	fileinfo = "stat";

	imagemagick = "magick";
	im = "magick"; # IMageMagick

	bottom = "btm";
}
