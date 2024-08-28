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
      dofile('${./setup.lua}')
    '';
  };
in
wrapNeovimUnstable neovim-unwrapped conf
