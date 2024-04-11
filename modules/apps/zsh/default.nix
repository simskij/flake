{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.arctic.apps.zsh;
in
  with lib;
{
  options.arctic.apps.zsh = {
    enable  = mkEnableOption "";
    dots    = mkOption { type = types.str;   default = ".config/zsh"; };
    aliases = mkOption { type = types.attrs; default = {};            };
    init    = mkOption { type = types.str;   default = "";            };
    
    addons = {
      starship = {
        enable = mkEnableOption "";
      };
    };
  };

  config = {
    programs = {
      zsh = {
        enable = cfg.enable;
      };
    };
    home-manager = {
      users = {
        "${username}" = {
          programs = {
            zsh = mkIf cfg.enable {
              enable = true;
              dotDir = cfg.dots;

              enableCompletion = true;
              autosuggestion.enable = true;
              initExtra = cfg.init;
              syntaxHighlighting.enable = true;

              history = {
                save = 1000;
                size = 1000;
                path = "$HOME/cache/zsh_history";
              };

              shellAliases = cfg.aliases;
            };
            starship = mkIf cfg.addons.starship.enable {
              enable = true;
              enableZshIntegration = cfg.enable;
            };
          };
        };
      };
    };
  };
}
