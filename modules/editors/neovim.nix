{ config, options, pkgs, lib, configDir, ... }:
let

in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  hm.programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      cmp-nvim-lsp
      nvim-lspconfig
      lspkind-nvim
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile "${configDir}/nvim/lua/cmp.lua";
      }

      {
        plugin = neovim-ayu;
        type = "lua";
        config = builtins.readFile "${configDir}/nvim/lua/ayu.lua";
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile "${configDir}/nvim/lua/telescope.lua";
      }
    ] ++ [ pkgs.vim-pio ];

    extraPackages = with pkgs; [
      pyright
      rnix-lsp
      sumneko-lua-language-server
      rust-analyzer
      clang-tools_15
    ];

    extraConfig = builtins.readFile "${configDir}/nvim/init.vim";
  };

  hm.home.file."${config.home-manager.users.eduardo.home.homeDirectory}/.config/nvim/lua/generic_lsp.lua".text = ''
          return function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end    '';

}
