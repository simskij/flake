{ hostname, ... }: {
  imports = [
    (./. + "/${hostname}")
  ];
}