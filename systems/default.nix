{ hostname, ... } : {
  imports = [
    (./. + "/${hostname}")
  ];
}