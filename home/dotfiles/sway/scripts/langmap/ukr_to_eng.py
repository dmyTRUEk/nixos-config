from fileinput import input as get_stdin

ukr_to_eng = {
	"й": "q",
	"ц": "w",
	"у": "e",
	"к": "r",
	"е": "t",
	"н": "y",
	"г": "u",
	"ш": "i",
	"щ": "o",
	"з": "p",
	"х": "[",
	"Х": "{",
	"ї": "]",
	"Ї": "}",
	#
	"ф": "a",
	"і": "s",
	"в": "d",
	"а": "f",
	"п": "g",
	"р": "h",
	"о": "j",
	"л": "k",
	"д": "l",
	"ж": ";",
	"Ж": ":",
	"є": "'",
	"Є": '"',
	#
	"я": "z",
	"ч": "x",
	"с": "c",
	"м": "v",
	"и": "b",
	"т": "n",
	"ь": "m",
	"б": ",",
	"Б": "<",
	"ю": ".",
	"Ю": ">",
	".": "/",
	",": "?",
	#
	"'": "`",
	"ʼ" :"~",
	'"': "@",
	"№" :"#",
	";" :"$",
	":" :"^",
	"?" :"&",
}

stdin_str = "".join(get_stdin())[:-1]

def f(c: str) -> str:
	if c.lower() in ukr_to_eng:
		if c.isupper():
			return ukr_to_eng[c.lower()].upper()
		return ukr_to_eng[c]
	return c

final_str = "".join(map(f, stdin_str))

print(final_str, end="")

