{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.arctic.apps.git;
in
  with lib;
{
  options.arctic.apps.git = {
    enable = mkEnableOption "";
    signing  = {
      key = mkOption { type = types.str; };
      enable = mkEnableOption "";
    };
    meta = {
      email = mkOption { type = types.str; };
      name = mkOption { type = types.str; };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${username}" = {
      programs = {
        git = {
          enable = true;

          userName = cfg.meta.name;
          userEmail = cfg.meta.email;

          signing = mkIf cfg.signing.enable {
            key = cfg.signing.key;
            signByDefault = true;
          };

          lfs = {
            enable = true;
          };

          extraConfig = {
            init.defaultBranch = "main";
            push.default = "matching";
            pull.rebase = true;
            commit.gpgSign = cfg.signing.enable;
            tag.gpgSign = cfg.signing.enable;
          };
          ignores = [
            "*.fdb_latexmk"
            "*.fls"
            "*.aux"
            "*.glo"
            "*.idx"
            "*.log"
            "*.toc"
            "*.ist"
            "*.acn"
            "*.acr"
            "*.alg"
            "*.bbl"
            "*.blg"
            "*.dvi"
            "*.glg"
            "*.gls"
            "*.ilg"
            "*.ind"
            "*.lof"
            "*.lot"
            "*.maf"
            "*.mtc"
            "*.mtc1"
            "*.out"
            "*.synctex.gz"
            "*.module.js"
            "*.routing.js"
            "*.component.js"
            "*.service.js"
            "*.map"
            ".DS_Store"
            ".vscode/"
            "node_modules/"
            "dist/"
            "bin/"
            ".tox/"
            ".mypy*/"
            "venv/"
            ".venv/"
            "__pycache__/"
          ];
        };
      };
    };
  };
}
