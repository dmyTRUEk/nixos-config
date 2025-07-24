# dmyTRUEk's random wallpaper

from os import listdir, system as exec_cmd
from os.path import isfile, join
from random import choice as random_choice
from sys import argv as cli_args
from time import sleep


def main():
	delay = cli_args[1]
	folders = cli_args[2:]
	delay_n_str = int(delay[:-1])
	match delay[-1]:
		case 's':
			delay_in_seconds = delay_n_str
		case 'm':
			delay_in_seconds = 60 * delay_n_str
		case 'h':
			delay_in_seconds = 60 * 60 * delay_n_str
		case _:
			raise ValueError

	images = []
	for folder in folders:
		images.extend(get_files_in_folder(folder))

	while True:
		img = random_choice(images)
		print(img)
		set_wallpaper(img)
		sleep(delay_in_seconds)


def get_files_in_folder(path: str) -> list[str]:
	# src: https://stackoverflow.com/questions/3207219/how-do-i-list-all-files-of-a-directory#3207973
	return [join(path, f) for f in listdir(path) if isfile(join(path, f)) and (f.endswith('.png') or f.endswith('.jpg') or f.endswith('.jpeg'))]


def set_wallpaper(img: str):
	exec_cmd(f"swaymsg -s $SWAYSOCK output '*' bg {img} fill")


if __name__ == '__main__':
	main()

