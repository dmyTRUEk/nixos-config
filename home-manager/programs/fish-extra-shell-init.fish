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

# TODO: colored man pages (maybe use `less`'s termcaps)

# termcap terminfo
# ks      smkx      make the keypad send commands
# ke      rmkx      make the keypad send digits
# vb      flash     emit visual bell
# mb      blink     start blink
# md      bold      start bold
# me      sgr0      turn off bold, blink and underline
# so      smso      start standout (reverse video)
# se      rmso      stop standout
# us      smul      start underline
# ue      rmul      stop underline

# set -gx LESS -RF
# set -gx LESS_TERMCAP_mb \e'[01;31m'
# set -gx LESS_TERMCAP_mb (set_color --bold red)
# set -gx LESS_TERMCAP_md \e'[01;38;5;74m'
# set -gx LESS_TERMCAP_me \e'[0m'
# set -gx LESS_TERMCAP_me (set_color normal)
# set -gx LESS_TERMCAP_se \e'[0m'
# set -gx LESS_TERMCAP_so \e'[38;5;246m'
# set -gx LESS_TERMCAP_ue \e'[0m'
# set -gx LESS_TERMCAP_us \e'[04;38;5;146m'

# set -x LESS "-R"
# set -gx LESS_TERMCAP_mb (printf "\033[01;31m")
# set -gx LESS_TERMCAP_md (printf "\033[01;31m")
# set -gx LESS_TERMCAP_me (printf "\033[0m")
# set -gx LESS_TERMCAP_se (printf "\033[0m")
# set -gx LESS_TERMCAP_so (printf "\033[01;44;33m")
# set -gx LESS_TERMCAP_ue (printf "\033[0m")
# set -gx LESS_TERMCAP_us (printf "\033[01;32m")

# set -gx LESS "-R"
# set -gx LESS_TERMCAP_me (set_color normal)
# set -gx LESS_TERMCAP_mb (set_color --bold red)
# set -gx LESS_TERMCAP_md (set_color --bold red)
# set -gx LESS_TERMCAP_us (set_color --bold red)
# set -gx LESS_TERMCAP_ue (set_color normal)

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
