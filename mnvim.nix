{ neovimUtils, vimPlugins, wrapNeovimUnstable, neovim-unwrapped }:
let
  conf = neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    plugins = with vimPlugins; [
      bufferline-nvim
      lualine-lsp-progress
      lualine-nvim
      neo-tree-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      orgmode
      plenary-nvim
      vim-nftables
      vim-signify
    ];
    luaRcContent = ''
      -- lspconfig
      local lspconfig = require('lspconfig')
      lspconfig.clangd.setup {}

      -- treesitter
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
        },
      }

      -- lualine
      require('lualine').setup {
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'lsp_progress'},
          lualine_x = {},
          lualine_y = {'filetype'},
          lualine_z = {'progress', 'location'}
        }
      }

      -- neo-tree
      require("neo-tree").setup {
        close_if_last_window = true,
        source_selector = {
          winbar = true,
          statusline = false,
          sources = {
            {
      	      source = "filesystem",
      	      display_name = "󰙅 Files",
            },
            {
      	      source = "buffers",
      	      display_name = " Buffers",
            },
            {
      	      source = "git_status",
      	      display_name = " Git"
            }
          },
        },
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true
        }
      }
      vim.keymap.set('n', '<C-n>', '<cmd>Neotree toggle<cr>', {silent = true})
      vim.keymap.set('n', '<C-f>', '<cmd>Neotree filesystem toggle<cr>', {silent = true})
      vim.keymap.set('n', '<C-b>', '<cmd>Neotree buffers toggle<cr>', {silent = true})

      -- bufferline
      require("bufferline").setup { }
    '';
  };
in
wrapNeovimUnstable neovim-unwrapped conf
