# dmyTRUEk's Waybar module script for current keyboard layout
#
# set initial text
swaymsg --raw --type get_inputs | \
	jq --raw-output '
		[ .[] |
			select(.type == "keyboard") |
			.xkb_active_layout_name |
			sub("English \\(US\\) \\(by dmyTRUEk\\)"; "en") |
			sub("Ukrainian \\(by dmyTRUEk\\)"; "uk") |
			sub("English \\(Colekam\\) \\(by dmyTRUEk\\)"; "en colekam") |
			sub("English \\(Colemak\\) \\(by dmyTRUEk\\)"; "en colemak") |
			sub("English \\(Workman\\) \\(by dmyTRUEk\\)"; "en workman")
		] |
		first
	' #| \
	# awk '{
	# 	getline iscaps < "/sys/class/leds/input3::capslock/brightness";
	# 	if (iscaps) { print(toupper($0)) } else { print(tolower($0)) };
	# 	system("") # flush the output
	# }'

# subscribe and update on every event
swaymsg --raw --type subscribe --monitor '["input"]' | \
	jq --unbuffered --raw-output '
		select(.change == "xkb_layout") |
		.input.xkb_active_layout_name |
		sub("English \\(US\\) \\(by dmyTRUEk\\)"; "en") |
		sub("Ukrainian \\(by dmyTRUEk\\)"; "uk") |
		sub("English \\(Colekam\\) \\(by dmyTRUEk\\)"; "en colekam") |
		sub("English \\(Colemak\\) \\(by dmyTRUEk\\)"; "en colemak") |
		sub("English \\(Workman\\) \\(by dmyTRUEk\\)"; "en workman")
	' #| \
	# awk '{
	# 	getline iscaps < "/sys/class/leds/input3::capslock/brightness"; # TODO: read every time?
	# 	if (iscaps) { print(toupper($0)) } else { print(tolower($0)) };
	# 	system("") # flush the output
	# }'
