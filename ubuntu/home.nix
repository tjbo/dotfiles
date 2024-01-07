{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.username = "tjbo";
  home.homeDirectory = "/home/tjbo";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.rustc
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
    pkgs."lua-language-server"
    pkgs.neofetch
    pkgs.nerdfonts
    pkgs.nixpkgs-fmt
    pkgs.nodejs
    pkgs.netlify-cli
    pkgs.nodePackages.create-react-app
    pkgs.nodePackages."@tailwindcss/language-server"
    pkgs.nodePackages.vscode-langservers-extracted
    pkgs.rustfmt
    pkgs.nodePackages.prettier
    pkgs.nodePackages.eslint
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.stylua
    pkgs.vscode-extensions.chenglou92.rescript-vscode
    pkgs.rust-analyzer
    pkgs.rnix-lsp
    pkgs.yarn
    pkgs.pure-prompt
    pkgs.neovim
    pkgs.nushell
  ];

  programs.git = {
    enable = true;
    userName = "tjbo";
    userEmail = "tom@prototypable.ca";
  };

  home.file."./.config/nvim/" = {
    source = ~/nixpkgs/dotfiles/lazyvim;
    recursive = true;
  };

  home.file.".config/lazygit/config.yml".text = builtins.readFile (../dotfiles/lazygit/config.yml);
  home.file.".config/zsh/fzf-bindings.zsh".source = ~/nixpkgs/dotfiles/zsh/fzf-bindings.zsh;
  home.file.".config/nushell/env.nu".source = ~/nixpkgs/dotfiles/nushell/env.nu;

  programs.nushell = import ../dotfiles/nushell/nushell.nix;
  programs.zsh = import ../dotfiles/zsh/zsh.nix;



}

