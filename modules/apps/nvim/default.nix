{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.arctic.apps.nvim;
  width = toString cfg.settings.tab-width;
in
  with lib;
{
  options.arctic.apps.nvim = {
    enable = mkEnableOption "";
    package = mkOption {
      type = types.attrs;
      default = pkgs.neovim-unwrapped;
    };
    plugins = {
      mason.enable      = mkEnableOption "";
      devicons.enable   = mkEnableOption "";
      tree.enable       = mkEnableOption "";
      easy-align.enable = mkEnableOption "";
      gitgutter.enable  = mkEnableOption "";
      telescope.enable  = mkEnableOption "";
      terminal.enable   = mkEnableOption "";
    };
    settings = {
      tab-width = mkOption { type = types.int; default = 4; };
      numbers   = mkEnableOption "";
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      users = {
        "${username}" = {
          programs = {
            neovim = {
              enable = true;
              package = cfg.package;
              viAlias = true;
              vimAlias = true;
              vimdiffAlias = true;
              withPython3 = true;
              extraConfig = ''
                lua << EOF
                vim.g.mapleader = ';'
                vim.g.maplocalleader = ';'
                vim.opt.expandtab = true
                vim.opt.shiftwidth = ${width}
                vim.opt.smartindent = true
                vim.opt.tabstop = ${width}
                vim.opt.softtabstop = ${width}
                vim.wo.number = ${width}
                vim.wo.wrap = false
                function map(mode, lhs, rhs, opts)
                  local options = {noremap = true, silent = true}
                  if opts then
                    options = vim.tbl_extend("force", options, opts)
                  end
                  vim.keymap.set(mode, lhs, rhs, options)
                end
                
                map('i', '<leader><leader>', '<Esc>'                )
                map('t', '<Esc>',            '<C-\\><C-n>'          )
                
                ${if cfg.plugins.terminal.enable
                  then ''
                      map('n', '<leader>t', ':ToggleTerm<CR>' )
                    ''
                  else ""}
                
                ${if cfg.plugins.tree.enable
                  then ''
                      map('n', '<leader>p', ':NvimTreeToggle<CR>')
                      map('n', '<leader><Space>', ':NvimTreeToggle<CR>')
                    ''
                  else ""}
                ${if cfg.plugins.telescope.enable
                  then ''
                      map('n', '<leader>ff',       ':Telescope find_files<CR>')
                      map('n', '<leader>fg',       ':Telescope live_grep<CR>' )
                      map('n', '<leader>fb',       ':Telescope buffers<CR>'   )
                      map('n', '<leader>fh',       ':Telescope help_tags<CR>' )
                    ''
                  else ""}
                EOF
              '';

              plugins = with pkgs.vimPlugins;
                [
                  plenary-nvim
                  nvim-treesitter
                  {
                    plugin = catppuccin-nvim;
                    type = "lua";
                    config = ''
                        require('catppuccin').setup({
                            flavour = 'mocha',
                            integrations = {
                                nvimtree = true,
                                telescope = true,
                            }
                        })
                        vim.cmd.colorscheme "catppuccin"
                    '';
                  }
                ]
                ++ (
                  if cfg.plugins.mason.enable then [{
                    plugin = mason-lspconfig-nvim;
                    type = "lua";
                    config = ''
                      require("mason").setup()
                      require("mason-lspconfig").setup({
                        ensure_installed = {
                          "pyright",
                          "ruff_lsp",
                          "pylsp",
                          "nil_ls"
                        },
                      })
                    '';
                  }] else [])
                ++ (
                  if cfg.plugins.devicons.enable then [
                    nvim-web-devicons
                  ] else [])
                ++ (
                  if cfg.plugins.tree.enable then [{
                    plugin = nvim-tree-lua;
                    type = "lua";
                    config = ''
                      require('nvim-tree').setup({
                        update_cwd = true
                      })
                    '';
                  }] else [])
                ++ (
                  if cfg.plugins.easy-align.enable then [
                    vim-easy-align
                  ] else [])
                ++ (
                  if cfg.plugins.gitgutter.enable then [
                    vim-gitgutter
                  ] else [])
                ++ (
                  if cfg.plugins.terminal.enable then [
                    toggleterm-nvim 
                  ] else [])
                ++ (
                  if cfg.plugins.telescope.enable then [
                    telescope-nvim 
                  ] else []);
            };
          };
        };
      };
    };
  };
}
