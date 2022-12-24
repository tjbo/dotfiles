{ config, pkgs, ... }:


{
  imports = [ <home-manager/nix-darwin> ];
  environment.systemPackages = with pkgs;
    [
      btop
      nixFlakes
      neovim
    ];

  nix.extraOptions = "experimental-features = nix-command flakes";

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;


  users.users.tjbo = {
    name = "tjbo";
    home = "/Users/tjbo";
  };

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    casks = [
      "alt-tab"
      "react-native-debugger"
      "visual-studio-code"
    ];
  };


  # add some post install hook if possible
  # launchctl unload -w/System/Library/LaunchAgents/com.apple.photoanalysisd.plist -w

  home-manager.users.tjbo = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnused
      fd
      fzf
      ripgrep
      cargo
      delta
      # todo: configure git 
      hack-font
      lazygit
      neofetch
      nixpkgs-fmt
      nodejs
      nodePackages.eslint
      nodePackages.react-native-cli
      nodePackages.typescript
      nodePackages.typescript-language-server
      stylua
      sumneko-lua-language-server
      vscode-extensions.chenglou92.rescript-vscode
      pure-prompt
      rustc
      rust-analyzer
      rnix-lsp
      vifm
      yarn
    ];

    #config files for lazygit
    home.file ."/Library/Application Support/lazygit/config.yml".text = builtins.readFile (dotfiles/lazygit/config.yml);

    # config files for vifm
    # home.file.".config/vifm/vifmrc".text = builtins.readFile(../vifm/vifmrc);
    # home.file.".config/vifm/colors/slate.vifm".text = builtins.readFile(../vifm/colors/slate.vifm);

    # neovim settings
    home.file.".config/nvim/settings.lua".source = dotfiles/nvim/settings.lua;

    # zsh keybindings for fzf
    home.file.".config/zsh/fzf-bindings.zsh".source = dotfiles/zsh/fzf-bindings.zsh;

    # iterm2 definition
    # home.file.".config/iterm2/terminfo.src".source = dotfiles/iterm2/terminfo.src;

    programs.neovim = import dotfiles/nvim/nvim.nix;
    # programs.alacritty = import ../alacritty/alacritty.nix;
    # programs.fzf = import ~/.config/dotfiles/fzf/fzf.nix;
    # programs.vscode = import ../vscode/vscode.nix;
    programs.zsh = import dotfiles/zsh/zsh.nix;
    home.stateVersion = "23.05";
  };
}
