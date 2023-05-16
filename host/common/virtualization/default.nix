{ ... }: {
  virtualisation = {
    libvirtd.enable = true;
    lxd.enable = true;
    multipass.enable = true;
  };
}
