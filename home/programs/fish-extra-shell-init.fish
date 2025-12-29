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

function mkcd -d "mkdir & cd"
	# src: https://fishshell.com/docs/current/cmds/function.html
	command mkdir -p $argv
	if test $status = 0
		switch $argv[(count $argv)]
			case '-*'

			case '*'
				cd $argv[(count $argv)]
				return
		end
	end
end

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
	set MAIN_FILE_HTML 'index.html'
	set MAIN_FILE_LATEX 'main.tex'
	set MAIN_FILE_LEAN 'main.lean'
	set MAIN_FILE_NIX 'main.nix'
	set MAIN_FILE_PYTHON 'main.py'
	set MAIN_FILE_RUST 'src/main.rs'
	set MAIN_FILE_RUST_IN_SRC 'main.rs'
	set MAIN_FILE_RUST_LIB 'src/lib.rs'
	set MAIN_FILE_RUST_LIB_IN_SRC 'lib.rs'
	set MAIN_FILE_TYPST 'main.typ'

	if test -f $MAIN_FILE_C
		nvim "$MAIN_FILE_C" $argv

	else if test -f $MAIN_FILE_CPP
		nvim "$MAIN_FILE_CPP" $argv

	else if test -f $MAIN_FILE_HTML
		nvim "$MAIN_FILE_HTML" $argv

	else if test -f $MAIN_FILE_LATEX
		nvim "$MAIN_FILE_LATEX" $argv

	else if test -f $MAIN_FILE_LEAN
		nvim "$MAIN_FILE_LEAN" $argv

	else if test -f $MAIN_FILE_NIX
		nvim "$MAIN_FILE_NIX" $argv

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

	else if test -f $MAIN_FILE_TYPST
		nvim "$MAIN_FILE_TYPST" $argv

	else
		echo 'No known main file found.'
	end
end

function ffmpeg-to-mp4 -d "convert to mp4 using ffmpeg"
	switch (count $argv)
		case 1
			set file_name $argv[1]
		case '*'
			echo 'Expected only one argument'
			return 1
	end
	set new_file_name (string replace -r '\.\w+$' '.mp4' $file_name)
	ffmpeg -i $file_name -c copy $new_file_name
end

function clear-and-gds-inf -d "`clear && gds` infinitely"
	while true
		command clear
		gds
		sleep 1
	end
end

function nvimcmddiff -d "view commands diff using neovim"
	set -l tmp1 (mktemp)
	set -l tmp2 (mktemp)
	eval $argv[1] > $tmp1
	eval $argv[2] > $tmp2
	nvim -d $tmp1 $tmp2
end

function auto-shutdown-on-low-battery-or-ram --argument threshold
	while true
		# Battery
		set capacity (cat /sys/class/power_supply/BAT1/capacity)

		# RAM
		set meminfo (cat /proc/meminfo)
		set mem_total (string match -r 'MemTotal:\s+(\d+)' $meminfo)[2]
		set mem_free  (string match -r 'MemAvailable:\s+(\d+)' $meminfo)[2]
		# Calculate used percentage
		set mem_used_percent (math "(1 - $mem_free / $mem_total) * 100")

		if test $capacity -le $threshold -o $mem_used_percent -ge 80
			shutdown 0
		end

		sleep 1
	end
end
