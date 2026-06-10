{ pkgs, ... }:
{
  environment = {
    etcBackupExtension = ".bak";

    packages = builtins.attrValues {
      inherit (pkgs)
        util-linuxMinimal
        procps
        findutils
        ripgrep
        gnumake
        gnupg

        gnutar
        gzip
        zip
        unzip

        man
        hostname
        tzdata

        nvim
        gitMinimal
        openssh
        ;
    };
  };
}
