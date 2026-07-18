{ inputs, ... }:
{
  import = [ inputs.disko.nixosModules.disko ];

  disko.devices = {
    disk.sda = {
      type = "disk";
      devices = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          # EFI BOOT
          ESP = {
            name = "ESP";
            label = "boot";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          # LUKS
          luks = {
            label = "luks";
            size = "258G";
            content = {
              type = "luks";
              name = "cryptroot";
              extraOpenArgs = [ ];
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };

    lvm_vg.pool = {
      type = "lvm_vg";
      lvs = {
        # SWAPFS
        swapfs = {
          size = "8G";
          content = {
            type = "swap";
            resumeDevice = true;
            extraArgs = [
              "-L"
              "swap"
            ];
          };
        };

        # BTRFS
        btrfs = {
          type = "btrfs";
          extraArgs = [
            "-L"
            "nixos"
            "-f"
          ];

          subvolumes = {
            "@" = {
              mountpoint = "/";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };

            "@home" = {
              mountpoint = "/home";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };

            "@nix" = {
              mountpoint = "/nix";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };

            "@persist" = {
              mountpoint = "/persist";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };

            "@log" = {
              mountpoint = "/var/log";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
          };
        };
      };
    };
  };
}
