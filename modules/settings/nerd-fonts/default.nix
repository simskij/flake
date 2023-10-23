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
        fonts = {
            fontconfig.enable = true;
            packages = with pkgs; mkIf ((lib.lists.count (a: true) cfg) > 0) [
              (nerdfonts.override {
                fonts = cfg;
              })
            ];
        };
    };
}
