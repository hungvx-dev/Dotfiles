{ pkgs, username, home, ... }:
{
  users.users.${username} = {
    name = username;
    home = home;
    shell = pkgs.fish;
  };
}
