{ username, ... }: {
  users.users."${username}" = {
    name = username;
    home = "/home/${username}/";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    description = username;
  };
}
