{ username, pkgs, ... }: {
  environment.variables = {
    AIDER_DARK_MODE = "true";
    AIDER_GITIGNORE = "false";
  };

  users.users."${username}".packages = [
    pkgs.unstable.aider-chat-full
  ];
}
