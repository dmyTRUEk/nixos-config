# [dmyTRUEk](https://github.com/dmyTRUEk)'s cool [NixOS](https://nixos.org/) config, with ✨flake✨

It definitely works on [NixOS](https://nixos.org/),
maybe even on any other Linux distro, if you somehow figure out how to install it
(hint: use [nix](https://github.com/NixOS/nix/) and [home-manager](https://github.com/nix-community/home-manager/)).

![Screenshot](https://raw.githubusercontent.com/dmyTRUEk/images/55d5e636f82f55223d1a81498087eee70de1ee75/screenshot_sway_20240825_185533.png)

# Configs:

## Text editors:
- [NeoVim](./home-manager/dotfiles/nvim/)

## Window Managers / Desktop Environments:
### Sway:
- Sway: [config](./home-manager/dotfiles/sway/config) + [scripts/](./home-manager/dotfiles/sway/scripts/)
- Waybar: [config](./home-manager/dotfiles/waybar/config) + [style.css](./home-manager/dotfiles/waybar/style.css)
- Anyrun: [anyrun.nix](./home-manager/programs/anyrun.nix) + [anyrun-theme.nix](./home-manager/programs/anyrun-theme.nix) + [anyrun.symbols.ron](./home-manager/programs/anyrun.symbols.ron)
- Swaylock: [config](./home-manager/dotfiles/swaylock/config)
- Mako: [mako.nix](./home-manager/programs/mako.nix)

## File managers and viewers:
- Yazi: [yazi.nix](./home-manager/programs/yazi.nix) + [yazi-theme-gruvbox.nix](./home-manager/programs/yazi-theme-gruvbox.nix)
- Zathura: [zathurarc](./home-manager/dotfiles/zathura/zathurarc)
- Swayimg: [config](./home-manager/dotfiles/swayimg/config)

## Terminal stuff:
- Shell: Fish: [fish.nix](./home-manager/programs/fish.nix) + [fish-aliases.nix](./home-manager/programs/fish-aliases.nix) + [fish-extra-shell-init.fish](./home-manager/programs/fish-extra-shell-init.fish)
- Alacritty: [alacritty.nix](./home-manager/programs/alacritty.nix)
- Kitty: [kitty.conf](./home-manager/dotfiles/kitty/kitty.conf)

## Other:
- Python REPL: [init_interactive_python.py](./home-manager/files/init_interactive_python.py)
- Vimium: [vimium-options.json](./home-manager/dotfiles/vimium/vimium-options.json)
