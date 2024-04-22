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

function nm
	set MAIN_FILE_C 'main.c'
	set MAIN_FILE_CPP 'main.cpp'
	set MAIN_FILE_LATEX 'main.tex'
	set MAIN_FILE_PYTHON 'main.py'
	set MAIN_FILE_RUST 'src/main.rs'
	set MAIN_FILE_RUST_IN_SRC 'main.rs'
	set MAIN_FILE_RUST_LIB 'src/lib.rs'
	set MAIN_FILE_RUST_LIB_IN_SRC 'lib.rs'

	if test -f $MAIN_FILE_C
		nvim "$MAIN_FILE_C" $argv

	else if test -f $MAIN_FILE_CPP
		nvim "$MAIN_FILE_CPP" $argv

	else if test -f $MAIN_FILE_LATEX
		nvim "$MAIN_FILE_LATEX" $argv

	else if test -f $MAIN_FILE_PYTHON
		nvim "$MAIN_FILE_PYTHON" $argv

	else if test -f $MAIN_FILE_RUST
		nvim "$MAIN_FILE_RUST" $argv

	else if test -f $MAIN_FILE_RUST_IN_SRC
		nvim "$MAIN_FILE_RUST_IN_SRC" $argv

	else if test -f $MAIN_FILE_RUST_LIB
		nvim "$MAIN_FILE_RUST_LIB" $argv

	else if test -f $MAIN_FILE_RUST_LIB_IN_SRC
		nvim "$MAIN_FILE_RUST_LIB_IN_SRC" $argv

	else
		echo 'No known main file found.'
	end
end
