# xdg.desktopEntries.yazi-in-kitty =
{
	name = "Yazi (in Kitty)";
	comment = "Terminal file manager launched in Kitty terminal emulator";
	#genericName = "";
	exec = ''kitty --title "yazi_with_cwd_memory" fish -C yazi_with_cwd_memory %U'';
	mimeType = [ "inode/directory" ];
	categories = [ "System" "FileTools" "FileManager" "Utility" "Core" ];
	terminal = false;
	icon = "user-desktop";
}
