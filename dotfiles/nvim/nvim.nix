with import <nixpkgs> { };

let
  vim-rescript = pkgs.vimUtils.buildVimPluginFrom2Nix
    {
      name = "vim-rescript";
      src = pkgs.fetchFromGitHub {
        owner = "rescript-lang";
        repo = "vim-rescript";
        rev = "master";
        hash = "sha256-aASUXqZD6ytt1vNxQiENDI44iDQ2tCg1DiBp9f7RFoI=";
      };
    };
  vim-lsp-saga = pkgs.vimUtils.buildVimPluginFrom2Nix
    {

      name = "vim-lsp-saga";
      src = pkgs.fetchFromGitHub {
        owner = "glepnir";
        repo = "lspsaga.nvim";
        rev = "master";
        hash =
          "sha256-i7N0vnzynzHj+mGthkDYVZmqYqvfqpr9XMwmGGUM4qI=";
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
    vimPlugins.vim-vsnip
    vimPlugins.nvim-cmp
    vimPlugins.cmp-nvim-lsp
    vimPlugins.indent-blankline-nvim
    vim-rescript
    vim-lsp-saga
    vimPlugins.cmp-cmdline
    vimPlugins.cmp-path
    vimPlugins.nvim-web-devicons
    vimPlugins.gitsigns-nvim
    vimPlugins.vim-code-dark
    vimPlugins.lightline-vim
    vimPlugins.null-ls-nvim
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-lsputils
    vimPlugins.nvim-treesitter
    vimPlugins.telescope-nvim # a modal panel that is used for pickers 
    vimPlugins.vim-commentary # adds easy way to comment / uncomment locs
    vimPlugins.vim-lastplace # opens file where you were last
    vimPlugins.which-key-nvim # shows a menu of custom key commands 
  ];
  extraConfig = "luafile ~/.config/nvim/settings.lua";
}

