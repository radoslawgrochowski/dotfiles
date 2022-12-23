# dotfiles

dotfiles and NixOS system conifiguration for my workstation setup

## setup

on clean NixOS instalation:

```sh
$ git clone git@github.com:radoslawgrochowski/dotfiles.git $HOME/Projects/dotfiles 
$ sudo nixos-rebuild --install-bootloader switch --flake '$HOME/Projects/dotfiles#radoslawgrochowski-desktop'
```

## inspiration

- https://github.com/jessarcher/dotfiles
- https://github.com/tiagovla/.dotfiles
- https://github.com/webpro/awesome-dotfiles
- https://github.com/ThePrimeagen/.dotfiles
- https://github.com/pmizio/vim-react-config
