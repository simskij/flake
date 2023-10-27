{
    config,
    lib,
    pkgs,
    ...
}:
let
    cfg = config.arctic.settings.nerd-fonts;
in
    with lib;
{
    options = {
      arctic.settings.nerd-fonts = mkOption {
        type = types.listOf types.str; 
      };
    };

    config = {
        nixpkgs.config.joypixels.acceptLicense = true;
        fonts = {
            fontconfig = {
              enable = true;
            };
            packages = with pkgs; [ joypixels ] ++
              
              (if ((lib.lists.count (a: true) cfg) > 0) then [
              (nerdfonts.override {
                fonts = cfg;
              })
            ] else []);
        };
    };
}
