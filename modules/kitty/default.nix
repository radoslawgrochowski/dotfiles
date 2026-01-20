{ username, pkgs, ... }:
{
  home-manager.users.${username} = {
    home.packages = [ pkgs.kitty ];
    home.file."./.config/kitty/kitty.conf".text = ''
      env PATH=/etc/profiles/per-user/${username}/bin:''${PATH}

      ${builtins.readFile ./kitty.conf}
    '';
  };
}
