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

		time-elapsed = "command time -f 'time elapsed: %E'";

		yy = "yazi_with_cwd_memory";

		fileinfo = "stat";
	};
	shellInit = ''
		function fish_greeting
		end

		# low priority first, high -- last
		fish_add_path -m ~/.cargo/bin
		fish_add_path -m ~/.local/bin

		set __fish_git_prompt_showdirtystate true
		set __fish_git_prompt_showcolorhints true
		set __fish_git_prompt_describe_style branch
		set __fish_git_prompt_showstashstate true

		function random_hash
			set default_len 6
			set max_len 128
			switch (count $argv)
				case 0
					set hash_len $default_len
				case 1
					set hash_len $argv[1]
				case '*'
					echo "Got too many args, exiting..."
					return 1
			end
			if test $hash_len -eq 0
				set hash_len $max_len
			end
			# TODO: if hash_len > max_len?
			date +%s%N | sha512sum | cut -c -$hash_len
		end

		function yazi_with_cwd_memory
			set tmp (mktemp -t "yazi-cwd.XXXXX")
			yazi $argv --cwd-file="$tmp"
			if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
				cd -- "$cwd"
			end
			rm -f -- "$tmp"
		end

		function fumo
			switch (count $argv)
				case 0
					gensoquote | fumosay | lolcat
				case 1
					set char $argv[1]
					gensoquote -c $char | fumosay -f $char | lolcat
				case '*'
					echo "Got too many args, exiting..."
					return 1
			end
		end

		function nixos-gc-my
			# check current gc roots: `nix-store --gc --print-roots`
			set argv_count (count $argv)
			#echo $argv_count
			if test $argv_count -ne 1
				echo "Expected 1 argument, got $argv_count, exiting..."
				return 1
			end
			set value $argv[1]
			#echo "value: $value"
			switch (string sub --start=-1 $value)
				case 'd'
					set days $value
					#echo "days: $days"

					# not needed?
					#echo "[MY INFO] Running `sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $days`..." | lolcat
					#sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $days

					echo "[MY INFO] Running `sudo nix-collect-garbage --delete-older-than $days` (clean up root pkgs)..." | lolcat
					sudo nix-collect-garbage --delete-older-than $days

					echo "[MY INFO] Running `nix-collect-garbage --delete-older-than $days` (clean up home pkgs)..." | lolcat
					nix-collect-garbage --delete-older-than $days

					# remove old generations from boot options
					echo "[MY INFO] Running `sudo nixos-rebuild switch --flake ~/.config/home-manager/` (to remove old boot options)..." | lolcat
					sudo nixos-rebuild switch --flake ~/.config/home-manager/
				case 0 1 2 3 4 5 6 7 8 9
					set gens $value
					echo "gens: $gens"
					echo "UNIMPLEMENTED"
					# TODO
					return 1
				case '*'
					echo "Expected number of generations (i.e. 10) or number of days (i.e. 10d) to leave, got `$value`, exiting..."
					return 1
			end
			# TODO: use `nix store optimise` at the end (no need bc it's automatic?)
			# TODO?: also clean up home-manager's generations
		end
	'';
}
