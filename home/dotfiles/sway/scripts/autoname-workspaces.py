'''
This script requires i3ipc-python package (install it from a system package manager or pip).
It adds icons to the workspace name for each open window.
Set your keybindings like this: `set $workspace1 workspace number 1`.
Add your icons to `WINDOW_ICONS`.

Based on
https://github.com/lgaboury/Sway-Waybar-Install-Script/blob/master/.config/sway/scripts/autoname-workspaces.py
which is based on
https://github.com/maximbaz/dotfiles/blob/master/bin/i3-autoname-workspaces
'''

from dataclasses import dataclass

import sys

import argparse
import signal
import logging

import i3ipc



# NOTES:
# - use only lowercase
# - assuming all icons to be ONE symbol (search for `ae36d1` in this file)
WINDOW_ICONS_BY_WINDOW_NAME: dict[str, str] = { # for CLI apps
	"btop": "󰄪",
	"ranger": "", #     
	"yazi": "", #     
}
WINDOW_ICONS_BY_APP_ID: dict[str, str] = {
	"alacritty": "", #   
	"blender": "󰂫",
	"blueman-manager": "",
	"discord": "", # 󰙯
	"firefox": "", # 󰈹
	"gimp": "",
	"gnome-boxes": "",
	"jetbrains-studio": "", # android-studio
	"kdenlive": "",
	"kitty": "󰄛",
	"krita": "",
	"libreoffice-calc": "󱪝",
	"libreoffice-impress": "󰐩",
	"libreoffice-writer": "󰷈",
	"libreoffice": "󰈙",
	"obs": "󰐾", # 󱔛 󰟞 󰐻 󰐾 󰻃 󰠿 󰚀 󱜠
	"skype": "󰒯", # 
	"steam": "", # 
	"swayimg": "", # 󰋩   󰥶 󰲍
	"telegram": "", # 
	"vlc": "󰕼",
	"zathura": "", # 󰈦
	"zoom": "Z",
	#     
}
WINDOW_ICONS_ALL: dict[str, str] = WINDOW_ICONS_BY_APP_ID | WINDOW_ICONS_BY_WINDOW_NAME


DEFAULT_ICON: str = "?"
ICONS_SEPARATOR: str = " "*1
NUMBER_ICONS_SEPARATOR: str = " "*1

WORKSPACE_NUMBER_TO_NAME: dict[int, str] = {
	1: "一",
	2: "二",
	3: "三",
	4: "四",
	5: "く",
	6: "わ",
	7: "え",
	8: "ら",
	9: "あ",
	10: "す",
	11: "ディ",
	12: "ふ",
	13: "ざ",
	14: "か",
	15: "つ",
	16: "を",
}


def main():
	parser = argparse.ArgumentParser(
		description="This script automatically changes the workspaces names in Sway depending on opened applications."
	)
	parser.add_argument(
		"--duplicates",
		"-d",
		action="store_false", # so default is true
		help="Pass it if you don't want an icon for EACH instance of the same application per workspace.",
	)
	parser.add_argument(
		"--exact",
		"-e",
		action="store_true", # so default is false
		help="Pass it if you want to match names exactly (default is substring).",
	)
	parser.add_argument(
		"--logfile",
		"-l",
		type=str,
		default="/tmp/sway-autoname-workspaces.log",
		help="Path for the logfile.",
	)
	args = parser.parse_args()
	global ARGUMENTS
	ARGUMENTS = args

	logging.basicConfig(
		level=logging.INFO,
		filename=ARGUMENTS.logfile,
		filemode="w",
		format="%(asctime)s [%(levelname)s] %(message)s",
	)

	def window_event_handler(ipc, event):
		if event.change in ["new", "close", "move"]:
			rename_workspaces(ipc)

	def workspace_event_handler(ipc, event):
		if event.change in ["init", "empty", "focus"]:
			rename_workspaces(ipc)

	ipc = i3ipc.Connection()

	ipc.on("window", window_event_handler)
	ipc.on("workspace", workspace_event_handler)

	for sig in [signal.SIGINT, signal.SIGTERM]:
		signal.signal(sig, lambda _signal, _frame: undo_window_renaming_and_exit(ipc))

	rename_workspaces(ipc)

	ipc.main()



def icon_for_window(window) -> str:
	if (app_id := window.app_id) is not None and len(app_id) > 0:
		window_name = window.name.lower()
		if icon := get_icon_for_window(window_name, WINDOW_ICONS_BY_WINDOW_NAME): # if not None
			return icon
		app_id = app_id.lower()
		if icon := get_icon_for_window(app_id, WINDOW_ICONS_BY_APP_ID): # if not None
			return icon
		logging.info(f"No icon available for window with {window_name=} and {app_id=}")
	else:
		# xwayland support
		class_name = window.window_class
		if len(class_name) > 0:
			class_name = class_name.lower()
			if icon := get_icon_for_window(class_name, WINDOW_ICONS_ALL): # if not None
				return icon
			logging.info(f"No icon available for window with {class_name=}")
	return DEFAULT_ICON


def get_icon_for_window(app_id_or_class_name: str, window_icons: dict[str, str]) -> None | str:
	for window_name, window_icon in window_icons.items():
		if is_this_window(window_name, app_id_or_class_name):
			return window_icon
	return None


def is_this_window(window_name: str, app_id_or_class_name: str) -> bool:
	if ARGUMENTS.exact:
		if window_name == app_id_or_class_name:
			return True
	else:
		if window_name in app_id_or_class_name:
			return True
	return False



@dataclass
class Workspace:
	num: int
	name: str
	icons: list[str]

	@staticmethod
	def renamed_from_string(fullname: str) -> "Workspace":
		num = get_workspace_number_from_fullname(fullname)
		name = "NA"
		icons = ""
		# TODO: refactor this mess.
		for key, value in WORKSPACE_NUMBER_TO_NAME.items():
			if fullname.startswith(value):
				num = key
				name = value
				icons = fullname[len(value):]
		icons = list(icons.strip()) # `ae36d1`: here we assume that icons consist of only one symbols
		return Workspace(num=num, name=name, icons=icons)


def get_workspace_number_from_fullname(fullname: str) -> int:
	return int(fullname.split(":")[0])



def rename_workspaces(ipc):
	for workspace_from_ipc in ipc.get_tree().workspaces():
		workspace_my: Workspace = Workspace.renamed_from_string(workspace_from_ipc.name)
		icons = []
		for window in workspace_from_ipc:
			if window.app_id is not None or window.window_class is not None:
				icon = icon_for_window(window)
				if not ARGUMENTS.duplicates and icon in icons:
					continue
				icons.append(icon)
		workspace_my.icons = icons
		new_name = construct_workspace_name(workspace_my)
		ipc.command(f"rename workspace '{workspace_from_ipc.name}' to '{new_name}'")


def construct_workspace_name(workspace: Workspace):
	# this `<n>:` is required for sway/waybar to know workspace's actual number
	new_name = str(workspace.num) + ":"
	new_name += WORKSPACE_NUMBER_TO_NAME[int(workspace.num)]
	if workspace.icons:
		new_name += NUMBER_ICONS_SEPARATOR + ICONS_SEPARATOR.join(workspace.icons)
	return new_name



def undo_window_renaming_and_exit(ipc):
	for workspace in ipc.get_tree().workspaces():
		workspace_num: int = get_workspace_number_from_fullname(workspace.name)
		ipc.command(f"rename workspace '{workspace.name}' to '{workspace_num}'")
	ipc.main_quit()
	sys.exit(0)



if __name__ == "__main__":
	main()

