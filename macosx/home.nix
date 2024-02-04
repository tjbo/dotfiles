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
    pkgs.fd
    pkgs.fzf
    pkgs.jdk11
    pkgs.ripgrep
    pkgs.cargo
    pkgs.delta
    pkgs.git
    pkgs.hack-font
    # pkgs.karabiner-elements
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
    pkgs.yarn
    pkgs.pure-prompt
  ];

  # copy lazygit config 
  home.file ."/Library/Application Support/lazygit/config.yml".text = builtins.readFile (../dotfiles/lazygit/config.yml);

  # copy neovim config 
  home.file.".config/nvim/settings.lua".source = ../dotfiles/nvim/settings.lua;

  # copy keybindings for fzf
  home.file.".config/zsh/fzf-bindings.zsh".source = ../dotfiles/zsh/fzf-bindings.zsh;

  # copy kitty config
  # programs.kitty.enable = true;
  home.file.".config/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;


  programs.neovim = import ../dotfiles/nvim/nvim.nix;
  programs.zsh = import ../dotfiles/zsh/zsh.nix;
}
