
{ config, pkgs, ... }:

{
imports = [ <home-manager/nix-darwin> ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
      pkgs.neovim
      pkgs.vim 
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;


users.users.tjbo = {
  name = "tjbo";
  home = "/Users/tjbo";
};
home-manager.users.tjbo= { pkgs, ... }: {
home.packages = with pkgs; [
   # alacritty
   # delta
    fzf
   # fd
   # gh
   # todo: configure git 
   # htop
    lazygit
    neofetch
    nixpkgs-fmt
    # nodejs
    pure-prompt
    # ripgrep
    # tabbed
    # udevil
    # udisks
   vifm
  ];

  #config files for lazygit
  home.file.".config/lazygit/config.yml".text =
    builtins.readFile(dotfiles/lazygit/config.yml);

  # config files for vifm
  # home.file.".config/vifm/vifmrc".text = builtins.readFile(../vifm/vifmrc);
  # home.file.".config/vifm/colors/slate.vifm".text = builtins.readFile(../vifm/colors/slate.vifm);

  # neovim settings
  home.file.".config/nvim/settings.lua".source = dotfiles/nvim/settings.lua;

  programs.neovim = import dotfiles/nvim/nvim.nix;
  # programs.alacritty = import ../alacritty/alacritty.nix;
  # programs.fzf = import ~/.config/dotfiles/fzf/fzf.nix;
  # programs.vscode = import ../vscode/vscode.nix;
  programs.zsh = import dotfiles/zsh/zsh.nix;	
	home.stateVersion = "23.05";
};
}
