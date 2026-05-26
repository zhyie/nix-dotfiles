{ ... }:
{
  services.displayManager = {
    enable = true;
    /**
      Commented option.
      Display manager, lemurs and ly
      doesn't support auto login
    */
    # autoLogin = {
    #   enable = true;
    #   user = elemAt hostConfig.users 0;
    # };
  };
}
