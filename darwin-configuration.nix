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
      "chromium"
      "android-studio"
      "kitty"
      "iterm2"
      "loom"
      "react-native-debugger"
      "visual-studio-code"
      "zulu11"
    ];
  };

  # add some post install hook if possible
  # launchctl unload -w/System/Library/LaunchAgents/com.apple.photoanalysisd.plist -w
  home-manager.users.tjbo = { pkgs, ... }: {
    home.packages = with pkgs; [
      bundletool
      fd
      fzf
      jdk11
      ripgrep
      cargo
      cocoapods
      delta
      # todo: configure git 
      hack-font
      lazygit
      neofetch
      nerdfonts
      nixpkgs-fmt
      nodejs
      netlify-cli
      nodePackages.create-react-app
      nodePackages."@tailwindcss/language-server"
      nodePackages.prettier
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint
      nodePackages.gatsby-cli
      nodePackages.vscode-langservers-extracted
      nodePackages.react-native-cli
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.serverless
      stylua
      sumneko-lua-language-server
      vscode-extensions.chenglou92.rescript-vscode
      pure-prompt
      # rustc
      # rustup
      rust-analyzer
      rnix-lsp
      vifm
      yarn
    ];

    # config files for lazygit
    home.file ."/Library/Application Support/lazygit/config.yml".text = builtins.readFile (dotfiles/lazygit/config.yml);

    # neovim settings
    home.file.".config/nvim/settings.lua".source = dotfiles/nvim/settings.lua;

    # zsh keybindings for fzf
    home.file.".config/zsh/fzf-bindings.zsh".source = dotfiles/zsh/fzf-bindings.zsh;

    # config for kitty
    home.file.".config/kitty/kitty.conf".source = dotfiles/kitty/kitty.conf;

    programs.neovim = import dotfiles/nvim/nvim.nix;
    programs.zsh = import dotfiles/zsh/zsh.nix;
    home.stateVersion = "23.05";
  };
}
