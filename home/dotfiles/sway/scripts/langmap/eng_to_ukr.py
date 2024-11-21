from fileinput import input as get_stdin

eng_to_ukr = {
	"q": "й",
	"w": "ц",
	"e": "у",
	"r": "к",
	"t": "е",
	"y": "н",
	"u": "г",
	"i": "ш",
	"o": "щ",
	"p": "з",
	"[": "х",
	"{": "Х",
	"]": "ї",
	"}": "Ї",
	#
	"a": "ф",
	"s": "і",
	"d": "в",
	"f": "а",
	"g": "п",
	"h": "р",
	"j": "о",
	"k": "л",
	"l": "д",
	";": "ж",
	":": "Ж",
	"'":"є",
	'"':"Є",
	#
	"z": "я",
	"x": "ч",
	"c": "с",
	"v": "м",
	"b": "и",
	"n": "т",
	"m": "ь",
	",": "б",
	"<": "Б",
	".": "ю",
	">": "Ю",
	"/": ".",
	"?": ",",
	#
	"`": "'",
	"~": "ʼ",
	"@": '"',
	"#": "№",
	"$": ";",
	"^": ":",
	"&": "?",
}

stdin_str = "".join(get_stdin())[:-1]

def f(c: str) -> str:
	if c.lower() in eng_to_ukr:
		if c.isupper():
			return eng_to_ukr[c.lower()].upper()
		return eng_to_ukr[c]
	return c

final_str = "".join(map(f, stdin_str))

print(final_str, end="")

