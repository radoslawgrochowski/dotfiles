# dotfiles

NixOS system configuration for my machines

## Host setup

### Nixos on Windows Subsystem for Linux (WSL)

Host based around https://github.com/nix-community/NixOS-WSL/tree/b4354a924111b7f09ba5a3d1ce38717c7f29a581

#### Instalation

1. Enable WSL (run `wsl --install`)
1. Follow NixOS-WSL instructions and run an NixOS-WSL instance.

#### Configuration

```sh
$ nix shell nixpkgs#git --extra-experimental-features nix-command  --extra-experimental-features flakes
$ git clone https://github.com/radoslawgrochowski/dotfiles.git $HOME/Projects/dotfiles
$ sudo adduser radoslawgrochowski
$ sudo su radoslawgrochowski
$ sudo nixos-rebuild switch --flake "$HOME/Projects/dotfiles#radoslawgrochowski-wsl"
```

#### SSH

Setup keys for root and current user

- [Generating a new ssh key and adding it to the ssh agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

- Copying keys to root (still need to verify how secure this is)

```sh
sudo mkdir -p /root/.ssh
sudo cp /home/$USER/.ssh/id_ed* /root/.ssh/
```

- Github keys can be updated here: https://github.com/settings/keys

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
$ git clone https://github.com/radoslawgrochowski/dotfiles.git $HOME/Projects/dotfiles
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
- https://github.com/breuerfelix/dotfiles
