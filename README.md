# [dmyTRUEk](https://github.com/dmyTRUEk)'s cool [NixOS](https://nixos.org/) config, with ✨flake✨

It definitely works on [NixOS](https://nixos.org/),
maybe even on any other Linux distro, if you somehow figure out how to install it
(hint: use [nix](https://github.com/NixOS/nix/) and [home-manager](https://github.com/nix-community/home-manager/)).

![Screenshot](https://raw.githubusercontent.com/dmyTRUEk/images/55d5e636f82f55223d1a81498087eee70de1ee75/screenshot_sway_20240825_185533.png)

# Configs:

## Text editors:
- [NeoVim](./home/dotfiles/nvim/)

## Window Managers / Desktop Environments:
### Sway:
- Sway: [config](./home/dotfiles/sway/config) + [scripts/](./home/dotfiles/sway/scripts/)
- Waybar: [config](./home/dotfiles/waybar/config) + [style.css](./home/dotfiles/waybar/style.css)
- Anyrun: [anyrun.nix](./home/programs/anyrun.nix) + [anyrun-theme.nix](./home/programs/anyrun-theme.nix) + [anyrun.symbols.ron](./home/programs/anyrun.symbols.ron)
- Swaylock: [config](./home/dotfiles/swaylock/config)
- Mako: [mako.nix](./home/programs/mako.nix)

## File managers and viewers:
- Yazi: [yazi.nix](./home/programs/yazi.nix) + [yazi-theme-gruvbox.nix](./home/programs/yazi-theme-gruvbox.nix)
- Zathura: [zathurarc](./home/dotfiles/zathura/zathurarc)
- Swayimg: [config](./home/dotfiles/swayimg/config)

## Terminal stuff:
- Shell: Fish: [fish.nix](./home/programs/fish.nix) + [fish-aliases.nix](./home/programs/fish-aliases.nix) + [fish-extra-shell-init.fish](./home/programs/fish-extra-shell-init.fish)
- Alacritty: [alacritty.nix](./home/programs/alacritty.nix)
- Kitty: [kitty.conf](./home/dotfiles/kitty/kitty.conf)

## Other:
- Python REPL: [init_interactive_python.py](./home/files/init_interactive_python.py)
- Vimium: [vimium-options.json](./home/dotfiles/vimium/vimium-options.json)
