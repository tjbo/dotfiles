{ config, pkgs, ... }:

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
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.ruby
    pkgs.bundletool
    pkgs.cocoapods
    pkgs.fd
    pkgs.fzf
    pkgs.jdk11
    pkgs.karabiner-elements
    pkgs.ripgrep
    pkgs.cargo
    pkgs.delta
    pkgs.git
    pkgs.hack-font
    pkgs.kitty
    pkgs.lazygit
    pkgs.neofetch
    pkgs.spotify
    # pkgs.nerdfonts
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
    pkgs.tree
    pkgs.lf
    pkgs.lua-language-server
    pkgs.stylua
    pkgs.vscode-extensions.chenglou92.rescript-vscode
    pkgs.rustfmt
    pkgs.rust-analyzer
    pkgs.rustywind
    pkgs.rnix-lsp
    pkgs.stylelint
    pkgs.skhd
    pkgs.yarn
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.pure-prompt
  ];

  # copy lazygit config 
  home.file ."/Library/Application Support/lazygit/config.yml".text = builtins.readFile (../dotfiles/lazygit/config.yml);

  # copy neovim config 
  home.file.".config/nvim/settings.lua".source = ../dotfiles/nvim/settings.lua;
  home.file.".config/karabiner/karabiner.json".source = ../dotfiles/karabiner/karabiner.json;

  # skhd 
  # home.file.".config/skhd/skhdrc".source = ../dotfiles/skhd/skhdrc;

  # copy kitty config
  # programs.kitty.enable = true;
  home.file.".config/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;

  programs.neovim = import ../dotfiles/nvim/nvim.nix;
  programs.zsh = import ../dotfiles/zsh/zsh.nix;


}
