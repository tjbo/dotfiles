with import <nixpkgs> { };

let
  vim-rescript = pkgs.vimUtils.buildVimPlugin
    {
      name = "vim-rescript";
      src = pkgs.fetchFromGitHub {
        owner = "rescript-lang";
        repo = "vim-rescript";
        rev = "master";
        hash = "sha256-l12sg9O5elqWTFRs9asa9xMnKw5GbV7ZB8HmtjcFVps=";
      };
    };
in
{
  enable = true;
  viAlias = true;
  plugins = with pkgs.vimPlugins; [
    vim-nix # support for writing nix 
    vim-rescript # support for writing rescript
    vimPlugins.bufferline-nvim # for top bar
    vimPlugins.typescript-tools-nvim
    vimPlugins.mini-nvim
    vimPlugins.conform-nvim
    vimPlugins.lualine-nvim # for bottom status
    vimPlugins.nui-nvim
    vimPlugins.nvim-notify
    vimPlugins.noice-nvim
    vimPlugins.nvim-treesitter-parsers.astro
    vimPlugins.plenary-nvim # dependency needed for telescope 
    vimPlugins.vim-vsnip
    vimPlugins.vim-prettier
    vimPlugins.nvim-cmp # auto-completion engine plugin
    vimPlugins.cmp-nvim-lsp # nvim-cmp source 
    vimPlugins.cmp-path # nvim-cmp source
    vimPlugins.cmp-buffer # nvim-cmp source
    vimPlugins.lspkind-nvim # adds vscode-like pictograms to neovim built-in LSP 
    vimPlugins.indent-blankline-nvim # adds indentation guides 
    vimPlugins.nvim-web-devicons # web dev icons
    vimPlugins.gitsigns-nvim # for symbols and to navigate doc based on git status 
    vimPlugins.vim-code-dark # main color scheme 
    vimPlugins.nvim-treesitter-parsers.lua
    vimPlugins.nvim-lspconfig # for setting up configs for LSP client 
    vimPlugins.nvim-treesitter-parsers.vimdoc
    vimPlugins.nvim-lsputils
    vimPlugins.nvim-treesitter
    vimPlugins.oil-nvim
    vimPlugins.telescope-nvim # a modal panel that is used for pickers 
    vimPlugins.vim-lastplace # opens file where you were last
    vimPlugins.which-key-nvim # shows a menu of keybindings 
  ];
  extraConfig = "luafile ~/.config/nvim/settings.lua";
}

