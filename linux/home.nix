{ config, pkgs, ... }:
with import <nixpkgs> { };
with lib;

{
  home.username = "tjbo";
  home.homeDirectory = "/home/tjbo";
  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
   home.packages = with pkgs; [
    alacritty
    delta
    fzf
    fd
    gh
    git
    htop
    lazygit
    neofetch
    nixpkgs-fmt
    nodejs
    pure-prompt
    ripgrep
    tabbed
    udevil
    udisks
    vifm
    zathura
    zsh
  ];

  #config files for lazygit
  home.file.".config/lazygit/config.yml".text = builtins.readFile(../lazygit/config.yml);

  # config files for vifm
  home.file.".config/vifm/vifmrc".text = builtins.readFile(../vifm/vifmrc);
  home.file.".config/vifm/colors/slate.vifm".text = builtins.readFile(../vifm/colors/slate.vifm);

  # neovim settings
  home.file.".config/nvim/settings.lua".source = ../nvim/settings.lua;

  programs.neovim = import ../nvim/nvim.nix;
  programs.alacritty = import ../alacritty/alacritty.nix;
  programs.fzf = import ../fzf/fzf.nix;
  programs.zsh = import ../zsh/zsh.nix;
  programs.vscode = import ../vscode/vscode.nix;
}
