wtype -M ctrl -P x
sleep 0.1
wl-paste \
	| python $HOME/.config/home-manager/home/dotfiles/sway/scripts/langmap/ukr_to_eng.py \
	| wl-copy
sleep 0.1
wtype -M ctrl -P v
