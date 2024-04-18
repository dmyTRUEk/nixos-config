# programs.fish.shellInit =

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
			echo 'Got too many args, exiting...'
			return 1
	end
	if test $hash_len -eq 0
		set hash_len $max_len
	end
	# TODO: if hash_len > max_len?
	date +%s%N | sha512sum | cut -c -$hash_len
end

function yazi_with_cwd_memory
	set tmp (mktemp -t 'yazi-cwd.XXXXX')
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
			echo 'Got too many args, exiting...'
			return 1
	end
end


function my-nixos-gc
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
			#echo "[MY INFO] Running `sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $days` # TODO desc" | lolcat
			#sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $days

			echo "[MY INFO] Running `sudo nix-collect-garbage --delete-older-than $days` # clean up root pkgs" | lolcat
			sudo nix-collect-garbage --delete-older-than $days

			echo "[MY INFO] Running `nix-collect-garbage --delete-older-than $days` # clean up home pkgs" | lolcat
			nix-collect-garbage --delete-older-than $days

			# remove old generations from boot options
			echo '[MY INFO] Running `sudo nixos-rebuild switch --flake ~/.config/home-manager/` # to remove old boot options' | lolcat
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


function my-nixos-update
	echo '[MY INFO] Running `nix flake update ~/.config/home-manager` # update flake inputs aka pkgs versions' | lolcat
	nix flake update ~/.config/home-manager

	echo '[MY INFO] Running `sudo nixos-rebuild boot --flake ~/.config/home-manager` # update root pkgs' | lolcat
	sudo nixos-rebuild boot --flake ~/.config/home-manager

	echo '[MY INFO] Running `home-manager switch` # update home pkgs' | lolcat
	home-manager switch
end


function my-nixos-rebuild-root-now
	echo '[MY INFO] Running `sudo nixos-rebuild switch --flake ~/.config/home-manager` # rebuild and switch now' | lolcat
	sudo nixos-rebuild switch --flake ~/.config/home-manager
end

function my-nixos-rebuild-root-later
	echo '[MY INFO] Running `sudo nixos-rebuild boot --flake ~/.config/home-manager` # rebuild and switch later (at next boot)' | lolcat
	sudo nixos-rebuild boot --flake ~/.config/home-manager
end

function my-nixos-check-root
	echo '[MY INFO] Running `nixos-rebuild build --flake ~/.config/home-manager` # check if current root configuration compiles' | lolcat
	nixos-rebuild build --flake ~/.config/home-manager
	echo '[MY INFO] OK' | lolcat
end


function my-nixos-rebuild-home-now
	echo '[MY INFO] Running `home-manager switch` # rebuild and switch now' | lolcat
	home-manager switch
end

#function my-nixos-rebuild-home-later
#	echo '[MY INFO] Running `` # TODO' | lolcat
#	echo 'UNIMPLEMENTED'
#	# TODO?
#	return 1
#end

function my-nixos-check-home
	echo '[MY INFO] Running `home-manager build` # check if current home configuration compiles' | lolcat
	home-manager build
	echo '[MY INFO] OK' | lolcat
end


function my-nixos-check
	#echo '[MY INFO] Running `my-nixos-check-root`' | lolcat
	my-nixos-check-root
	#echo '[MY INFO] Running `my-nixos-check-home`' | lolcat
	my-nixos-check-home
end
