{
  config,
  configDir,
  lib,
  pkgs,
  user,
  ...
}:
with lib; let
  nodePkgs = with pkgs.nodePackages; [
    eslint
    vscode-langservers-extracted
    typescript-language-server
  ];
in {
  hm.home.packages = with pkgs; [nodePackages.typescript];
  hm.programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins;
      [
        plenary-nvim
        nvim-treesitter
        markdown-preview-nvim
        vim-nix
        lspkind-nvim
        cmp-nvim-lsp
        cmp-treesitter
        cmp-git
        nvim-lspconfig
        molokai
        {
          plugin = Navigator-nvim;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/navigator.lua";
        }
        {
          plugin = pkgs.edu.tokyo-night-nvim;
          type = "lua";
          config = ''
            vim.cmd[[colorscheme tokyonight-night]]
          '';
        }
        Coqtail
        {
          plugin = hop-nvim;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/hop-nvim.lua";
        }
        {
          plugin = orgmode;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/orgmode.lua";
        }
        {
          plugin = harpoon;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/harpoon.lua";
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/telescope.lua";
        }
        {
          plugin = luasnip;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/luasnip.lua";
        }
        {
          plugin = nvim-surround;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/surround.lua";
        }
        {
          plugin = nvim-cmp;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/cmp.lua";
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/treesitter.lua";
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile "${configDir}/nvim/lua/lualine.lua";
        }
      ]
      ++ (with pkgs.unstable.vimPlugins; [typst-vim]);

    extraPackages = with pkgs;
      [
        pyright
        rnix-lsp
        sumneko-lua-language-server
        rust-analyzer
        clang-tools_15
        gopls
      ]
      ++ nodePkgs;

    extraLuaPackages = ps: with ps; [lua-lsp];

    extraPython3Packages = ps: with ps; [];

    extraConfig = builtins.readFile "${configDir}/nvim/init.vim";
  };

  hm.home.file."${
    config.home-manager.users.${user}.home.homeDirectory
  }/.config/nvim/lua/generic_lsp.lua".text = ''
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
      vim.keymap.set('n', '<space>se', vim.diagnostic.setloclist, bufopts)
      vim.keymap.set('n', '<space>Se', vim.diagnostic.setqflist, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end    '';
}
