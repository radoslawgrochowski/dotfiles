{ username, ... }: {
  # TODO: Consider making this module
  homebrew = {
    casks = [ "aerospace" ];
    taps = [ "nikitabobko/tap" ];
  };

  home-manager.users.${username} = {
    home.file."./.aerospace.toml".source = ./aerospace.toml;
  };
}
