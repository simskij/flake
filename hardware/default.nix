{ hostname, ... }: {
  imports = [
    (./. + "/${hostname}")
  ];
}
