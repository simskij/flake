{ fetchFromGitHub, buildGoModule, lib, stdenv, pkgs, pkgconfig }:
let
  pname = "snap";
  version = "2.57.6";

  src = fetchFromGitHub {
    owner = "snapcore";
    repo = "snapd";
    rev = "${version}";
    sha256 = "sha256-zk/+L8nRedR6VyaJZ+w/bPKqZHQbdn2630mpMbIVgqc=";
  };

in buildGoModule {
  inherit pname version src;
  doCheck = false;
  system = builtins.currentSystem;

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.libcap
    pkgs.libseccomp
    pkgs.xfsprogs
    pkgs.linuxHeaders
  ];

  postInstall = ''
    echo $out
    cd data/systemd
    make install \
      DBUSSERVICESDIR=$out/usr/share/dbus-1/services \
      BINDIR=$out/usr/bin \
      SYSTEMDSYSTEMUNITDIR=$out/etc/systemd/system \
      SNAP_MOUNT_DIR=$out/var/lib/snapd/snap \
      DESTDIR="$pkgdir"
  '';

  subPackages = [
    "./cmd/snap"
    # "./..."
  ];
  vendorSha256 = "sha256-KeoRBkXbQ46KApezVIyE5rac5SJUmjPwiXeSAEsH8vk=";
  proxyVendor = true;
  
  meta = with lib; {
    description = "Snap";
    homepage = "https://github.com/snapcore/snapd";
    license = licenses.mit;
  };
}
