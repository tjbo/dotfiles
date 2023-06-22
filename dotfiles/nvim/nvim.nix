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
in
{
  enable = true;
  viAlias = true;
  plugins = with pkgs.vimPlugins; [
    vimPlugins.plenary-nvim # dependency for another plugin
    vimPlugins.vim-surround
    vim-nix # syntax for nix
    vimPlugins.vim-vsnip
    vimPlugins.nvim-cmp
    vimPlugins.cmp-nvim-lsp
    vimPlugins.indent-blankline-nvim # adds indentation guides 
    vim-rescript # needed for rescript to work
    vimPlugins.cmp-cmdline
    vimPlugins.cmp-path
    vimPlugins.nvim-web-devicons # icons
    vimPlugins.gitsigns-nvim # for managing git
    vimPlugins.vim-code-dark # main color scheme 
    vimPlugins.lightline-vim # for status bar
    vimPlugins.null-ls-nvim # provides a way for non-LSP sources to hook into vims LSP client
    vimPlugins.nvim-lspconfig # for setting up configs for LSP client 
    vimPlugins.nvim-lsputils # todo: figureout if I need this
    vimPlugins.nvim-treesitter #todo: do I need this?
    vimPlugins.telescope-nvim # a modal panel that is used for pickers 
    vimPlugins.vim-commentary # adds easy way to comment / uncomment locs
    vimPlugins.vim-lastplace # opens file where you were last
    vimPlugins.which-key-nvim # shows a menu of custom key commands 
  ];
  extraConfig = "luafile ~/.config/nvim/settings.lua";
}

