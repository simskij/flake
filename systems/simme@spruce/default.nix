{
  stateVersion,
  username,
  pkgs,
  ...
}:
let
  on = {
    enable = true;
  };
in
{
  arctic = {
    apps = {
      nvim = on // {
        settings = {
          tab-width  = 2;
          numbers    = true;
        };
        plugins = {
          devicons   = on;
          easy-align = on;
          gitgutter  = on;
          mason      = on;
          telescope  = on;
          terminal   = on;
          tree       = on;
        };
      };
      zsh = on // {
        dots = ".config/zsh";
        init = ''
          export PATH=$PATH:/run/current-system/sw/bin/
          export PATH=$PATH:/etc/profiles/per-user/$USER/bin/
          export PATH=$PATH:/opt/homebrew/bin/
        '';
        aliases = {
          auth   = "ssh-add ~/.ssh/id_rsa";
          ll     = "ls -la";
          reload = "source ~/.config/zsh/.zshrc";
        };
        addons = {
          starship = on;
        };
      };
    };
    packages = with pkgs; [
      cargo
      nodejs
    ];
  };

  users = {
    users = {
      simme = {
        name = "simme";
        home = "/Users/simme";
        shell = pkgs.zsh;
      };
    };
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    hostPlatform = "aarch64-darwin";
  };
}
