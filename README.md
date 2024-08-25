# [dmyTRUEk](https://github.com/dmyTRUEk)'s cool [NixOS](https://nixos.org/) config, with ✨flake✨

It definitely works on [NixOS](https://nixos.org/),
maybe even on any other Linux distro, if you somehow figure out how to install it
(hint: use [nix](https://github.com/NixOS/nix/) and [home-manager](https://github.com/nix-community/home-manager/)).

# Table of Contents:
## Screenshot:
![Screenshot](https://raw.githubusercontent.com/dmyTRUEk/images/55d5e636f82f55223d1a81498087eee70de1ee75/screenshot_sway_20240825_185533.png)

## Configs:

### Text editors:
- NeoVim: [init.vim](./home-manager/dotfiles/nvim/)

### Window Managers / Desktop Environments:
#### Sway:
- Sway: [config](./home-manager/dotfiles/sway/config) + [scripts](./home-manager/dotfiles/sway/scripts/)
- Waybar: [config](./home-manager/dotfiles/waybar/config) + [style.css](./home-manager/dotfiles/waybar/style.css) + [modules/kblayout](./home-manager/dotfiles/waybar/modules/kblayout)
- Anyrun: [yofi.config](./home-manager/dotfiles/yofi/yofi.config)
- Swaylock: [config](./home-manager/dotfiles/swaylock/config)
- Mako: [config](./home-manager/dotfiles/mako/config)

### File managers and viewers:
- Ranger: [rc.conf](./home-manager/dotfiles/ranger/rc.conf)
  \+ [rifle.conf](./home-manager/dotfiles/ranger/rifle.conf)
  \+ [colorschemes/ala_gruvbox.py](./home-manager/dotfiles/ranger/colorschemes/ala_gruvbox.py)
- Zathura: [zathurarc](./home-manager/dotfiles/zathura/zathurarc)
- Imv: [config](./home-manager/dotfiles/imv/config)

### Terminal Emulators:
- Alacritty: [alacritty.yml](./home-manager/dotfiles/alacritty/alacritty.yml)
- Kitty: [kitty.conf](./home-manager/dotfiles/kitty/kitty.conf)

### Other:
- Shell: Zsh + Oh My ZSH!: [.zshrc](./home-manager/dotfiles/.zshrc)
  \+ [.zprofile](./home-manager/dotfiles/.zprofile)
- Aur helper: Paru: [paru.conf](./home-manager/dotfiles/paru/paru.conf)
- Custom "apps": [ranger-by-kitty.desktop](./home-manager/dotfiles/apps/ranger-by-kitty.desktop)
- Systemd services: [sway-relative-keyboard-rs.service](./home-manager/dotfiles/systemd/user/sway-relative-keyboard-rs.service)
- Vimium: [vimium-options.json](./home-manager/dotfiles/vimium/vimium-options.json)
