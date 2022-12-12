with import <nixpkgs> {};

let
  vim-rescript = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-rescript";
    src = pkgs.fetchFromGitHub {
      owner = "rescript-lang";
      repo = "vim-rescript";
      rev = "master";
      hash = "sha256-aASUXqZD6ytt1vNxQiENDI44iDQ2tCg1DiBp9f7RFoI=";
    };
  };
in

{
  enable = true;
  viAlias = true;
  plugins = with pkgs.vimPlugins; [
    vim-nix
    vim-rescript
    vimPlugins.gitsigns-nvim
    vimPlugins.lightline-vim 
    vimPlugins.null-ls-nvim
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-lsputils
    vimPlugins.nvim-treesitter
    vimPlugins.telescope-nvim
    vimPlugins.vifm-vim # file browser
    vimPlugins.vim-commentary # adds easy way to comment / uncomment locs
    vimPlugins.vim-lastplace # opens file where you were last
    vimPlugins.vimwiki
  ];
  extraConfig = "luafile ~/.config/nvim/settings.lua"; 
}

