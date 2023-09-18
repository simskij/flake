{ lib , pkgs , ... }:
let
  rev = "v3.0.1";
in
pkgs.stdenvNoCC.mkDerivation {
  name = "fira-mono-nerd";
  dontConfigue = false;

  src = pkgs.fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/${rev}/FiraMono.zip";
    sha256 = "sha256-N65IZXBD27j+6vWJxgEsS+DQY100Q8ia7H350BeKYas=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/opentype/
  
    runHook postInstall
  '';

  meta = with lib; {
    description = "A patched Fira Mono with Nerd Font Icons";
    maintainers = [ simskij ];
  };
}
