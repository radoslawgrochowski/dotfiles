# dotfiles

NixOS system configuration for my machines 

## setup

### preparation

1. Setup SSH Keys

- either [generate new setup](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
  and pass public key to github
- or just copy exisiting ones

2. make sure root also knows the key
   (still need to verify how secure this is)
   ```sh
   sudo cp /home/radoslawgrochowski/.ssh/id_ed* /root/.ssh/
   ```

### nix

```sh
$ git clone git@github.com:radoslawgrochowski/dotfiles.git $HOME/Projects/dotfiles
$ sudo nixos-rebuild --install-bootloader switch --flake '$HOME/Projects/dotfiles#radoslawgrochowski-desktop'
```

## cheatsheet

### updating single flake input

```sh
sudo nix flake lock --update-input config-wp
```

## inspiration

see also:

- https://github.com/jessarcher/dotfiles
- https://github.com/tiagovla/.dotfiles
- https://github.com/ThePrimeagen/.dotfiles
- https://github.com/pmizio/vim-react-config
