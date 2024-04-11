{ disks ? [ "/dev/nvme0n1" ], ... }: {

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f3c105b6-53ed-49b0-88dd-400c75efe1be";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/f3c105b6-53ed-49b0-88dd-400c75efe1be";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5D0C-77FD";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/82802f24-3406-4758-ba7f-7966065403a7"; }
    ];

# disko.devices = {
 #   disk = {
 #     vdb = {
 #       type = "disk";
 #       device = builtins.elemAt disks 0;
 #       content = {
 #         type = "table";
 #         format = "gpt";
 #         partitions = [
 #           {
 #             name = "ESP";
 #             start = "1MiB";
 #             end = "100MiB";
 #             bootable = true;
 #             content = {
 #               type = "filesystem";
 #               format = "vfat";
 #               mountpoint = "/boot";
 #               mountOptions = [
 #                 "defaults"
 #               ];
 #             };
 #           }
 #           {
 #             name = "luks";
 #             start = "100MiB";
 #             end = "100%";
 #             content = {
 #               type = "luks";
 #               name = "crypted";
 #               extraOpenArgs = [ "--allow-discards" ];
 #               keyFile = "/tmp/secret.key";
 #               content = {
 #                 type = "lvm_pv";
 #                 vg = "pool";
 #               };
 #             };
 #           }
 #         ];
 #       };
 #     };
 #   };
 #   lvm_vg = {
 #     pool = {
 #       type = "lvm_vg";
 #       lvs = {
 #         root = {
 #           size = "900G";
 #           content = {
 #             type = "filesystem";
 #             format = "btrfs";
 #             mountpoint = "/";
 #             mountOptions = [
 #               "defaults"
 #             ];
 #           };
 #         };
 #       };
 #     };
 #   };
 # };
}
