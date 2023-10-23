{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.arctic.apps.kitty;
in
  with lib;
{
  options.arctic.apps.kitty = {
    enable = mkEnableOption "";
    padding = mkOption {
      type = types.int;
      default = 18;
    };
    font = mkOption {
      type = types.str;
      default = "FiraCode Nerd Font";
    };
    shell = mkOption {
      type = types.attrs;
      default = pkgs.zsh;
    };
    theme = mkOption {
      type = types.str;
      default = "Catppuccin-Mocha"; 
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      programs = {
        kitty = {
          enable = true;
          theme = cfg.theme;
          
          font = {
            name = cfg.font;
          };
          
          settings = {
            window_padding_width = cfg.padding;
          };
          
          shellIntegration = {
            enableBashIntegration = (cfg.shell == pkgs.bash);
            enableZshIntegration  = (cfg.shell == pkgs.zsh);
          };
        };
      };
    };
  };
}
