{ hostname, ... } : {
  imports = [
    (./. + "/${hostname}")
  ];
}
