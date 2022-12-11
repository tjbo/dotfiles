with import <nixpkgs> {};
{
  enable = true;
  viAlias = true;
  plugins = with pkgs.vimPlugins; [
    vim-nix
    vimPlugins.formatter-nvim
    vimPlugins.gitsigns-nvim
    vimPlugins.vim-floaterm
    vimPlugins.lightline-vim 
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-lsputils
    vimPlugins.nvim-treesitter
    # vimPlugins.rust-vim # plugin for rust
    vimPlugins.telescope-nvim
    vimPlugins.vifm-vim # file browser
    vimPlugins.vim-commentary # adds easy way to comment / uncomment locs
    # vimPlugins.vim-jsx-pretty # jsx syntax
    vimPlugins.vim-lastplace # opens file where you were last
    vimPlugins.vimwiki
    # vimPlugins.yats-vim #typescript syntax
  ];
  extraConfig = "luafile ~/.config/nvim/settings.lua"; 
}

