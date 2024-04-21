# programs.fish.shellInit +=

function my-nixos-check
	#echo '[MY INFO] Running `my-nixos-check-root`' | lolcat
	my-nixos-check-root
	#echo '[MY INFO] Running `my-nixos-check-home`' | lolcat
	my-nixos-check-home
end

function my-nixos-update
	echo '[MY INFO] Running `nix flake update ~/.config/home-manager` # update flake inputs aka pkgs versions' | lolcat
	nix flake update ~/.config/home-manager

	my-nixos-rebuild-now
end

function my-nixos-rebuild-now
	my-nixos-rebuild-root-now
	my-nixos-rebuild-home-now
end


function my-nixos-check-root
	echo '[MY INFO] Running `nixos-rebuild build --flake ~/.config/home-manager` # check if current root configuration compiles' | lolcat
	nixos-rebuild build --flake ~/.config/home-manager
	# TODO?: delete generated folder
	echo '[MY INFO] OK' | lolcat
end

function my-nixos-rebuild-root-now
	echo '[MY INFO] Running `sudo nixos-rebuild switch --flake ~/.config/home-manager` # rebuild and switch now' | lolcat
	# TODO: require sudo explicitly
	sudo nixos-rebuild switch --flake ~/.config/home-manager
end

function my-nixos-rebuild-root-later
	echo '[MY INFO] Running `sudo nixos-rebuild boot --flake ~/.config/home-manager` # rebuild and switch later (at next boot)' | lolcat
	# TODO: require sudo explicitly
	sudo nixos-rebuild boot --flake ~/.config/home-manager
end


function my-nixos-check-home
	echo '[MY INFO] Running `home-manager build` # check if current home configuration compiles' | lolcat
	home-manager build
	# TODO?: delete generated folder
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


function my-nixos-print-generations-root
	echo '[MY INFO] Running `nix-env --list-generations`' | lolcat
	nix-env --list-generations
end

function my-nixos-print-generations-home
	echo '[MY INFO] Running `home-manager generations`' | lolcat
	home-manager generations
end

function my-nixos-print-gcroots-by-ls
	echo '[MY INFO] Running `ll /nix/var/nix/gcroots/auto/`' | lolcat
	ll /nix/var/nix/gcroots/auto/
end

function my-nixos-print-gcroots-by-nix
	echo '[MY INFO] Running `nix-store --gc --print-roots`' | lolcat
	nix-store --gc --print-roots
end

function my-nixos-gc
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

			# needed or not?
			#echo "[MY INFO] Running `sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $days` # TODO desc" | lolcat
			# TODO: require sudo explicitly?
			#sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system $days

			echo "[MY INFO] Running `sudo nix-collect-garbage --delete-older-than $days` # clean up root pkgs" | lolcat
			# TODO: require sudo explicitly?
			sudo nix-collect-garbage --delete-older-than $days

			echo "[MY INFO] Running `nix-collect-garbage --delete-older-than $days` # clean up home pkgs" | lolcat
			nix-collect-garbage --delete-older-than $days

		case 'n'
			# remove last character, which is `n`
			set gens (echo $value | rev | cut -c 2- | rev)
			#echo "gens: $gens"
			echo "[MY INFO] Running `nix-env --delete-generations +$gens` # delete all root generations except $gens last" | lolcat
			nix-env --delete-generations +$gens

			set hm_gens (
				home-manager generations \
				| awk '{print $5}' \
				| tail -n +$(expr $gens + 1)
			)
			for hm_gen in $hm_gens
				echo "[MY INFO] Running `home-manager remove-generations $hm_gen` # delete generation $hm_gen" | lolcat
				home-manager remove-generations $hm_gen
			end

			echo "[MY INFO] Running `nix-collect-garbage` # delete unreachable pkgs" | lolcat
			nix-collect-garbage

		case '*'
			echo "Expected number of generations (i.e. 10n) or days (i.e. 10d) to leave, got `$value`, exiting..."
			return 1
	end

	# remove old generations from boot options
	echo '[MY INFO] Running `sudo nixos-rebuild switch --flake ~/.config/home-manager` # to remove old boot options' | lolcat
	# TODO: require sudo explicitly?
	sudo nixos-rebuild switch --flake ~/.config/home-manager

	# TODO: use `nix store optimise` at the end (no need bc it's automatic?)
	# TODO?: also clean up home-manager's generations
end
