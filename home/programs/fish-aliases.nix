# programs.fish.shellAliases =
{
	# neovim
	neovim = "nvim";
	n = "nvim";
	"n." = "nvim .";
	nd = "nvim -d";
	ndc = "nvimcmddiff";
	nr = "nvim -R"; # open in read-only mode
	nhoriz = "nvim -o"; # split with horizontal divider
	nvert  = "nvim -O"; # split with vertical divider

	# ls
	ls = "ls"; # to exclude possibility of aliasing real ls
	# better ls: eza (community maintained fork of exa)
	l  = "eza";
	la = "eza -a";
	ll = "eza -al";

	mkdir = "mkdir -p";
	#mkcd = ""; ---> ./fish-extra-shell-init.fish

	cl = "clear ; git status || clear";

	# cd
	#"-" = "cd -"; # TODO: find alternative
	cdd = "cd ~/.config/home-manager";
	".." = "cd ..";
	"..." = "cd ../..";
	"..2" = "cd ../..";
	"...." = "cd ../../..";
	"..3" = "cd ../../..";
	"..4" = "cd ../../../..";
	"..5" = "cd ../../../../..";
	cdp = "cd ~/projects";
	cdv = "cd ~/Videos";
	cdm = "cd ~/Music";

	please = "sudo";
	grep = "grep -i --color";
	findtextinfiles = "grep -rn";
	duai = "dua i";

	# git
	g = "git";
	ga = "git add";
	"ga." = "git add .";
	gai = "git add --intent-to-add";
	gap = "git add --patch";
	"gap." = "git add --patch .";
	gb = "git branch";
	gc = "git commit";
	gca = "git commit --amend"; # change msg of last commit
	gcm = "git commit -m";
	gch = "git checkout"; # delete changes
	gchb = "git checkout -b"; # change branch?
	gchp = "git checkout -p"; # delete changes patch (interactively)
	"gchp." = "git checkout -p ."; # delete changes patch (interactively) here (in this folder)
	gcl = "git clone";
	gcls = "git clone --depth 1"; # shallow
	gd = "git diff";
	"gd." = "git diff .";
	gds = "git diff --staged";
	"gds." = "git diff --staged .";
	gf = "git fetch";
	gfo = "git fetch origin";
	gl = "git log --oneline --graph --decorate";
	gll = "git log --decorate --graph";
	gm = "git merge";
	gmt = "git mergetool";
	gpull = "git pull";
	gpush = "git push";
	gpush-force-wl = "git push --force-with-lease";
	grs = "git restore --staged";
	"grs." = "git restore --staged .";
	grsp = "git restore --staged --patch";
	"grsp." = "git restore --staged --patch .";
	gs = "git status -u --find-renames=1";
	gss = "git status";
	gsh = "git show";
	gstash = "git stash push --keep-index"; # TODO: do i need keep-index? does cause "bugs" when `gap` -> `gstash` -> ... (`gc`?) -> `gstashp`
	# gstash = "git stash push";
	gstashp = "git stash pop";
	gstash-drop-all = "git stash clear";
	gstash-drop = "git stash drop";
	gstash-list = "git stash list";
	gsw = "git switch";

	whatismyip = "curl -s https://icanhazip.com";
	whatismylocalip = "ip addr | grep -oE '192\.168\.[0-9]{1,3}\.[0-9]{1,3}' | head -n 1";

	dv = "yt-dlp";
	dm = "yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail";
	dm_without_cover = "yt-dlp -x --audio-format mp3 --embed-metadata";
	#random_hash = "";

	cds = "cd ~/.config/home-manager/home/dotfiles/sway";
	cdw = "cd ~/.config/home-manager/home/dotfiles/waybar";

	nixi = "nix repl --file '<nixpkgs>'"; # nix interactive
	nx   = "nvim ~/.config/home-manager/";
	nif  = "nvim ~/.config/home-manager/flake.nix";
	nifl = "nvim -R ~/.config/home-manager/flake.lock"; # open in read-only mode
	niflm= "nvim    ~/.config/home-manager/flake.lock";
	nic  = "nvim ~/.config/home-manager/os/configuration-common.nix";
	nicp = "nvim ~/.config/home-manager/os/configuration-psyche.nix";
	nick = "nvim ~/.config/home-manager/os/configuration-knight.nix";
	nichp= "nvim ~/.config/home-manager/os/hardware-configuration-psyche.nix";
	nichk= "nvim ~/.config/home-manager/os/hardware-configuration-knight.nix";
	nih  = "nvim ~/.config/home-manager/home/home-common-common.nix";
	nihm = "nvim ~/.config/home-manager/home/home-myshko-common.nix";
	nihp = "nvim ~/.config/home-manager/home/home-myshko-psyche.nix";
	nihk = "nvim ~/.config/home-manager/home/home-myshko-knight.nix";

	nfa = "nvim ~/.config/home-manager/home/programs/fish-aliases.nix";
	nfe = "nvim ~/.config/home-manager/home/programs/fish-extra-shell-init.fish";
	ny  = "nvim ~/.config/home-manager/home/programs/yazi.nix";

	nn  = "nvim ~/.config/home-manager/home/dotfiles/nvim/init.lua +'set autochdir'";
	nns = "nvim ~/.config/home-manager/home/dotfiles/nvim/snippets/ +'set autochdir'";
	ns  = "nvim ~/.config/home-manager/home/dotfiles/sway/config +'set autochdir'";
	nss = "nvim ~/.config/home-manager/home/dotfiles/sway/scripts/ +'set autochdir'";
	nw  = "nvim ~/.config/home-manager/home/dotfiles/waybar/config +'set autochdir'";
	nz  = "nvim ~/.config/home-manager/home/dotfiles/zathura/zathurarc";

	nipy= "nvim ~/.config/home-manager/home/files/init_interactive_python.py";

	nfh  = "nvim -R ~/.local/share/fish/fish_history"; # open in read-only mode
	nfhm = "nvim    ~/.local/share/fish/fish_history";

	nre = "nvim README.md";

	# rust related:
	nc  = "nvim Cargo.toml";
	ncl = "nvim -R Cargo.lock"; # open in read-only mode
	nclm= "nvim    Cargo.lock";
	nru = "nvim rust-toolchain.toml";

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

	interactive_python = "python -i ~/.config/home-manager/home/files/init_interactive_python.py";
	ipy = "interactive_python";

	time-elapsed = "command time -f 'time elapsed: %E'";

	yy = "yazi_with_cwd_memory";

	fileinfo = "stat";

	imagemagick = "magick";
	im = "magick"; # IMageMagick

	bottom = "btm";

	nf  = "nvim flake.nix";
	nfl = "nvim -R flake.lock"; # open in read-only mode
	nflm= "nvim    flake.lock";

	ff = "fastfetch";

	temp = "math $(cat /sys/class/thermal/thermal_zone0/temp) / 1000";

	zip = "zip -r";

	pkg-version-get = "sh ~/.config/home-manager/home/files/pkg_version_get.sh";
	pkg-version-sub = "sh ~/.config/home-manager/home/files/pkg_version_sub.sh";

	nl  = "nvim lakefile.lean";
	nlm = "nvim lake-manifest.json";

	yappy = "python ~/projects/yappy/yappy.py";

	ngi = "nvim .gitignore";
}
