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
  lightline-statusline-tabs = pkgs.vimUtils.buildVimPluginFrom2Nix {
      name = "statuslinetabs";
      src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "lightline-statuslinetabs";
      rev = "master";
      hash ="sha256-WigOGD31hiK2HqY4tBHZ6qIPyVdEBKwjoSDomuuNi9w=";
  };
  };
in
{
  enable = true;
  viAlias = true;
  plugins = with pkgs.vimPlugins; [
    vimPlugins.plenary-nvim
    vimPlugins.vim-surround 
    vim-nix
    vimPlugins.nvim-cmp
    vimPlugins.cmp-nvim-lsp
    vimPlugins.indent-blankline-nvim
    vim-rescript
    vimPlugins.cmp-cmdline
    vimPlugins.cmp-path
    vimPlugins.gitsigns-nvim
    vimPlugins.vim-code-dark
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
    vimPlugins.which-key-nvim
  ];
  extraConfig = "luafile ~/.config/nvim/settings.lua"; 
}

