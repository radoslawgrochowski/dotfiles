# dotfiles

nixos/nix-darwin system configuration for my machines

## Host setup

### Nixos on Windows Subsystem for Linux (WSL)

Host based around https://github.com/nix-community/NixOS-WSL/tree/b4354a924111b7f09ba5a3d1ce38717c7f29a581

#### Installation

1. (Optional) Install a NerdFont and configure it in your terminal emulator
2. Enable WSL by running `wsl --install` in PowerShell/Command Prompt
3. Follow the [NixOS-WSL installation instructions](https://github.com/nix-community/NixOS-WSL) to set up a NixOS-WSL instance

#### Configuration

```sh
# Install git using Nix
nix shell nixpkgs#git --extra-experimental-features nix-command --extra-experimental-features flakes

# Clone dotfiles repository
git clone https://github.com/radoslawgrochowski/dotfiles.git $HOME/Projects/dotfiles

# Create your user account
sudo adduser radoslawgrochowski

# Switch to your user account
sudo su radoslawgrochowski

# Apply NixOS configuration from the flake
sudo nixos-rebuild switch --flake "$HOME/Projects/dotfiles#radoslawgrochowski-wsl"
```

#### SSH Setup

1. Generate SSH keys for your user account:

   - Follow [GitHub's guide on generating SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

2. Copy keys to root (for system operations requiring root):

   ```sh
   sudo mkdir -p /root/.ssh
   sudo cp /home/$USER/.ssh/id_ed* /root/.ssh/
   ```

3. Add your SSH key to GitHub: https://github.com/settings/keys

## Inspiration

These repositories provided ideas for this configuration:

- https://github.com/tiagovla/.dotfiles
- https://github.com/pmizio/vim-react-config
- https://github.com/breuerfelix/dotfiles
