{
  config,
  configDir,
  lib,
  pkgs,
  ...
}:
with lib; {
  hm.home.packages = with pkgs; [nodePackages.typescript];
  hm.programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-treesitter
      markdown-preview-nvim
      vim-nix
      cmp-treesitter
      cmp-git
      {
        plugin = Navigator-nvim;
        type = "lua";
        config = builtins.readFile "${configDir}/nvim/lua/navigator.lua";
      }
      {
        plugin = hop-nvim;
        type = "lua";
        config = builtins.readFile "${configDir}/nvim/lua/hop-nvim.lua";
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
    ];

    extraConfig = builtins.readFile "${configDir}/nvim/init.vim";
  };
}
