{ config, pkgs, ... }:
{
  home.username = "tjbo";
  home.homeDirectory = "/home/tjbo";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.bundletool
    pkgs.libgcc
    pkgs.fd
    pkgs.fzf
    pkgs.jdk11
    pkgs.ripgrep
    pkgs.cargo
    pkgs.delta
    pkgs.git
    pkgs.hack-font
    pkgs.lazygit
    pkgs.neofetch
    pkgs.nerdfonts
    pkgs.nixpkgs-fmt
    pkgs.nodejs
    pkgs.netlify-cli
    pkgs.nodePackages.create-react-app
    pkgs.nodePackages."@astrojs/language-server"
    pkgs.nodePackages."@tailwindcss/language-server"
    pkgs.nodePackages.vscode-langservers-extracted
    pkgs.nodePackages.prettier
    pkgs.nodePackages.eslint
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.lua-language-server
    pkgs.vscode-extensions.chenglou92.rescript-vscode
    pkgs.rust-analyzer
    pkgs.rnix-lsp
    pkgs.yarn
    pkgs.pure-prompt
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.file .".config/lazygit/config.yml".text = builtins.readFile (../dotfiles/lazygit/config.yml);
  home.file.".config/nvim/settings.lua".source = ../dotfiles/nvim/settings.lua;
  home.file.".config/zsh/fzf-bindings.zsh".source = ../dotfiles/zsh/fzf-bindings.zsh;

  programs.neovim = import ../dotfiles/nvim/nvim.nix; # copy lazygit config 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = import ../dotfiles/zsh/zsh.nix;

  programs.git = {
    enable = true;
    userName = "tjbo";
    userEmail = "tom@prototypable.ca";
  };

}
