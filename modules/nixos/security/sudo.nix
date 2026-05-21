{ ... }:
{
  security.sudo = {
    extraRules = [
      {
        users = [ "zhyie" ];
        commands = [
          {
            command = "ALL";
            options = [
              "NOPASSWD"
              "SETENV"
            ];
          }
        ];
      }
    ];
  };
}
