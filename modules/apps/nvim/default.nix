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
      breadcrumbs.enable = mkEnableOption "";
      bufferline.enable  = mkEnableOption "";
      cmp.enable         = mkEnableOption "";
      devicons.enable    = mkEnableOption "";
      easy-align.enable  = mkEnableOption "";
      gitgutter.enable   = mkEnableOption "";
      illuminate.enable  = mkEnableOption "";
      lualine.enable     = mkEnableOption "";
      lsp.enable         = mkEnableOption "";
      telescope.enable   = mkEnableOption "";
      terminal.enable    = mkEnableOption "";
      tree.enable        = mkEnableOption "";
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
                                navic = {
                                  enabled = true,
                                  custom_bg = "NONE",
                                },
                                illuminate = {
                                  enable = true,
                                  lsp = false
                                },
                            }
                        })
                        vim.cmd.colorscheme "catppuccin"
                    '';
                  }
                ]
                ++ (if cfg.plugins.breadcrumbs.enable then [{
                  plugin = nvim-navic;
                  type = "lua";
                  config = ''
                    require('nvim-navic').setup({
                      highlight = true,
                      lsp = {
                        auto_attach = true
                      }
                    })
                  '';
                
                }] else [])
                ++ (if cfg.plugins.cmp.enable then [
                  luasnip
                  cmp_luasnip
                  cmp-buffer
                  cmp-path
                  cmp-cmdline
                  {
                    plugin = nvim-cmp;
                    type = "lua";
                    config = ''
                      local cmp = require('cmp')
                      cmp.setup({
                        snippet = {
                          expand = function (args)
                            require('luasnip').lsp_expand(args.body)
                          end,
                        },
                        window = {
                          completion = cmp.config.window.bordered(),
                          documentation = cmp.config.window.bordered(),
                        },
                        sources = {
                          { name = 'nvim_lsp' },
                          { name = 'luasnip'  },
                          { name = 'buffer'   },
                        },
                      })
                    '';
                  }] else [])
                ++ (
                  if cfg.plugins.illuminate.enable then [{
                    plugin = vim-illuminate;
                    type = "lua";
                    config = ''
                      require('illuminate').configure({
                        providers = {
                          "lsp",
                          "treesitter",
                          "regex",
                        },
                        delay = 120,
                        filetypes_denylist = {
                          "dirvish",
                          "fugitive",
                          "alpha",
                          "NvimTree",
                          "lazy",
                          "neogitstatus",
                          "Trouble",
                          "lir",
                          "Outline",
                          "spectre_panel",
                          "toggleterm",
                          "DressingSelect",
                          "TelescopePrompt",
                        },
                        under_cursor = true,
                      })
                    '';
                  }] else [])
                ++ (
                  if cfg.plugins.bufferline.enable then [{
                    plugin = bufferline-nvim;
                    type = "lua";
                    config = ''
                      require("bufferline").setup({
                        highlights = require("catppuccin.groups.integrations.bufferline").get(),
                        options = {
                          offsets = {
                            {
                              filetype = "NvimTree",
                              text = "",
                              highlight = "PanelHeading",
                              padding = 1,
                            }
                          },
                          separator_style = "thin",
                        }
                      })
                    '';
                  }] else [])
                ++ (
                  if cfg.plugins.lsp.enable then [
                    nvim-lspconfig
                    mason-nvim
                    mason-lspconfig-nvim
                    {
                      plugin = lsp-zero-nvim;
                      type = "lua";
                      config = ''
                        local zero = require('lsp-zero')
                        
                        require('mason').setup()
                        require('mason-lspconfig').setup({
                          ensure_installed = {
                            "bashls",
                            "gopls",
                            "lua_ls",
                            "nil_ls",
                            "pylsp",
                            "terraformls",
                          },
                          handlers = {
                            zero.default_setup,
                          },
                        })

                        zero.on_attach(
                          function(client, buffer)
                            zero.default_keymaps({buffer = bufnr})
                            if client.server_capabilities.documentSymbolProvider then
                              require('nvim-navic').attach(client, bufnr)
                            end 
                          end
                        )
                        zero.setup_servers({
                          "bashls",
                          "gopls",
                          "lua_ls",
                          "nil_ls",
                          "pylsp",
                          "terraformls"
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
                  if cfg.plugins.lualine.enable then [{
                    plugin = lualine-nvim;
                    type = "lua";
                    config = ''
                      require('lualine').setup {

                        sections = {
                          lualine_a = {
                            { 'mode', fmt = function() return " " end }
                          },
                          lualine_c = {}
                        },
                        options = {
                          theme = "catppuccin",
                          component_separators = { left = "", right = "" },
                          section_separators = { left = "", right = "" },
                          globalstatus = true
                        }
                      }
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
