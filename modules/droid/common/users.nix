{ hostConfig, ... }:
{
  user = {
    userName = builtins.head hostConfig.users;
  };
}
