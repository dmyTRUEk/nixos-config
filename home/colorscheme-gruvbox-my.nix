# ? =
{ inputs, ... }: {
	imports = [
		inputs.nix-colors.colorScheme.gruvbox-dark-pale
	];

	colorScheme = {
		slug = "gruvbox-by-dmytruek";
		name = "Gruvbox by dmyTRUEk";
		author = "dmyTRUEk (github:dmyTRUEk), Dawid Kurek (dawikur@gmail.com), morhetz (github:morhetz/gruvbox)";
		palette = {
			base00 = "#000000";  # ----
			base01 = "#222222";  # ---
			base02 = "#282828";  # --
			#base03 = "#5D5766"; # -
			#base04 = "#bebcbf"; # +
			#base05 = "#dedcdf"; # ++
			#base06 = "#edeaef"; # +++
			base07 = "#ffffff";  # ++++
			#base08 = "#A92258"; # red
			#base09 = "#918889"; # orange
			#base0A = "#804ead"; # yellow
			#base0B = "#C6914B"; # green
			#base0C = "#7263AA"; # aqua/cyan
			#base0D = "#8E7DC6"; # blue
			#base0E = "#953B9D"; # purple
			#base0F = "#59325C"; # brown
		};
	};
}
