{ username }: {
  users.users."${username}".home = "/home/${username}/";
}
