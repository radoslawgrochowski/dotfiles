{ username, ... }: {
  homebrew = {
    enable = true;
    casks = [ ];
  };
  home-manager.users."${username}".programs.fish.interactiveShellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';
}
