# programs.fish.shellInit +=

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
