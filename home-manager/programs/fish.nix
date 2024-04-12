# programs.fish =
{
	enable = true;
	shellAliases = {
		# neovim
		neovim = "nvim";
		n = "nvim";
		"n." = "nvim .";
		nd = "nvim -d";
		nr = "nvim -R"; # open in read-only mode
		nh = "nvim -o"; # split with horizontal divider
		nv = "nvim -O"; # split with vertical divider

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

		yy = "yazi_with_cwd_memory";

		fileinfo = "stat";
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
		function yazi_with_cwd_memory
			set tmp (mktemp -t "yazi-cwd.XXXXX")
			yazi $argv --cwd-file="$tmp"
			if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
				cd -- "$cwd"
			end
			rm -f -- "$tmp"
		end
	'';
}
