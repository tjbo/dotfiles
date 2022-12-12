with import <nixpkgs> {};

let
  vim-rescript = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-rescript";
    src = pkgs.fetchFromGitHub {
      owner = "rescript-lang";
      repo = "vim-rescript";
      rev = "master";
      # rev = "d0c36a77cc63c22648e792796b1815b44164653a";
      hash = "sha256-aASUXqZD6ytt1vNxQiENDI44iDQ2tCg1DiBp9f7RFoI=";
    };
  };
in

{
  enable = true;
  viAlias = true;
  plugins = with pkgs.vimPlugins; [
    vim-nix
    # vimPlugins.coc-nvim
    # vscode-extensions.chenglou92.rescript-vscode
    vimPlugins.neo-tree-nvim
    vimPlugins.formatter-nvim
    vimPlugins.gitsigns-nvim
    # vimPlugins.vim-floaterm
    vimPlugins.lightline-vim 
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-lsputils
    vimPlugins.nvim-treesitter
    # vimPlugins.rust-vim # plugin for rust
    vimPlugins.telescope-nvim
    vim-rescript
    vimPlugins.vifm-vim # file browser
    vimPlugins.vim-commentary # adds easy way to comment / uncomment locs
    # vimPlugins.vim-jsx-pretty # jsx syntax
    vimPlugins.vim-lastplace # opens file where you were last
    vimPlugins.vimwiki
    # vimPlugins.yats-vim #typescript syntax
    # test 222
  ];
  extraConfig = "luafile ~/.config/nvim/settings.lua"; 
}

