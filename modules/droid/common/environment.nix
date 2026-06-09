{ pkgs, ... }:
{
  environment = {
    etcBackupExtension = ".bak";

    packages = builtins.attrValues {
      inherit (pkgs)
        #: common packages
        procps
        killall
        diffutils
        findutils
        utillinux
        tzdata
        hostname
        man
        gnugrep
        gnupg
        gnused
        gnutar
        bzip2
        gzip
        xz
        zip
        unzip

        nano
        gitMinimal
        openssh
        ;
    };
  };
}
