{ config, pkgs, ... }:

let
  # Fetching the specific Nixpkgs version (24.05) we want to use
  nixpkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/24.05.tar.gz") {};
in

{

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tjbo";
  home.homeDirectory = "/Users/tjbo";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  # Set the Home Manager `nixpkgs` channel explicitly
  # programs.home-manager.nixpkgs = nixpkgs;

  home.packages = [
    nixpkgs.httpie
    nixpkgs.tree-sitter
    nixpkgs.awscli2
    # nixpkgs.ruby
    nixpkgs.prettierd
    nixpkgs.bundletool
    nixpkgs.cocoapods
    nixpkgs.fd
    nixpkgs.fzf
    # nixpkgs.jdk11
    nixpkgs.karabiner-elements
    nixpkgs.ripgrep
    nixpkgs.cargo
    nixpkgs.delta
    nixpkgs.git
    nixpkgs.hack-font
    nixpkgs.kitty
    nixpkgs.lazygit
    # nixpkgs.neofetch
    nixpkgs.nodePackages.firebase-tools
    nixpkgs.spotify
    # nixpkgs.nerdfonts
    nixpkgs.nixpkgs-fmt
    nixpkgs.nodejs
    # nixpkgs.netlify-cli
    nixpkgs.nodePackages.create-react-app
    nixpkgs.nodePackages_latest.eas-cli
    nixpkgs.nodePackages."@astrojs/language-server"
    nixpkgs.nodePackages."@tailwindcss/language-server"
    nixpkgs.nodePackages.vscode-langservers-extracted
    nixpkgs.nodePackages.prettier
    nixpkgs.nodePackages.eslint
    nixpkgs.nodePackages.serverless
    nixpkgs.nodePackages.typescript
    nixpkgs.nodePackages.typescript-language-server
    # nixpkgs.tree
    # nixpkgs.lf
    nixpkgs.lua-language-server
    nixpkgs.stylua
    nixpkgs.vscode-extensions.chenglou92.rescript-vscode
    nixpkgs.rustfmt
    nixpkgs.rust-analyzer
    nixpkgs.rustywind
    # nixpkgs.rnix-lsp
    nixpkgs.stylelint
    nixpkgs.yarn
    nixpkgs.zsh-autosuggestions
    nixpkgs.zsh-syntax-highlighting
    nixpkgs.pure-prompt
  ];

  # copy lazygit config 
  home.file ."/Library/Application Support/lazygit/config.yml".text = builtins.readFile (../dotfiles/lazygit/config.yml);

  # copy neovim config 
  home.file.".config/nvim/settings.lua".source = ../dotfiles/nvim/settings.lua;
  home.file.".config/karabiner/karabiner.json".source = ../dotfiles/karabiner/karabiner.json;

  # copy kitty config
  home.file.".config/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;

  programs.neovim = import ../dotfiles/nvim/nvim.nix;
  programs.zsh = import ../dotfiles/zsh/zsh.nix;


}
