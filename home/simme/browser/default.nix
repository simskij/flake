{ ... }: {
  programs = {
    chromium = {
      enable = true;
      extensions = [
        "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "ldgfbffkinooeloadekpmfoklnobpien" # raindrop
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        "kbfnbcaeplbcioakkpcpgfkobkghlhen" # grammarly 
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" # 1password
      ];
    };
  };
}
