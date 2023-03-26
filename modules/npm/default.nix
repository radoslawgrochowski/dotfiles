{ username, ... }:

{
  home-manager.users.${username} = {
    home.file."./.npmrc".source = ./.npmrc;
  };
}
