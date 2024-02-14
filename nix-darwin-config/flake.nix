{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.vim
          ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."Thomass-Mac-mini" = nix-darwin.lib.darwinSystem {
        modules = [ configuration home-manager.darwinModules.home-manager ];
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.tjbo2 = { pkgs, ... }: {
        stateVersion = "23.05"; # read below
      };

      home.homeDirectory = "/Users/tjbo2";


      home.packages = [
        nixpkgs.ruby
        nixpkgs.bundletool
        nixpkgs.cocoapods
        nixpkgs.fd
        nixpkgs.fzf
        nixpkgs.jdk11
        nixpkgs.ripgrep
        nixpkgs.cargo
        nixpkgs.delta
        nixpkgs.git
        nixpkgs.hack-font
        nixpkgs.lazygit
        nixpkgs.neofetch
        # pkgs.nerdfonts
        nixpkgs.nixpkgs-fmt
        nixpkgs.nodejs
        nixpkgs.netlify-cli
        nixpkgs.nodePackages.create-react-app
        nixpkgs.nodePackages."@astrojs/language-server"
        nixpkgs.nodePackages."@tailwindcss/language-server"
        nixpkgs.nodePackages.vscode-langservers-extracted
        nixpkgs.nodePackages.prettier
        nixpkgs.nodePackages.eslint
        nixpkgs.nodePackages.typescript
        nixpkgs.nodePackages.typescript-language-server
        nixpkgs.tree
        nixpkgs.lf
        nixpkgs.lua-language-server
        nixpkgs.stylua
        nixpkgs.vscode-extensions.chenglou92.rescript-vscode
        nixpkgs.rustfmt
        nixpkgs.rust-analyzer
        nixpkgs.rustywind
        nixpkgs.rnix-lsp
        nixpkgs.stylelint
        nixpkgs.skhd
        nixpkgs.yarn
        nixpkgs.zsh-autosuggestions
        nixpkgs.zsh-syntax-highlighting
        nixpkgs.pure-prompt
      ];

      # copy lazygit config 
      home.file ."/Library/Application Support/lazygit/config.yml".text = builtins.readFile (../dotfiles/lazygit/config.yml);

      # copy neovim config 
      home.file.".config/nvim/settings.lua".source = ../dotfiles/nvim/settings.lua;

      # skhd 
      # home.file.".config/skhd/skhdrc".source = ../dotfiles/skhd/skhdrc;

      # copy kitty config
      # need to add kitty above
      # programs.kitty.enable = true;
      home.file.".config/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;

      programs.neovim = import ../dotfiles/nvim/nvim.nix;
      programs.zsh = import ../dotfiles/zsh/zsh.nix;

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Thomass-Mac-mini".pkgs;
    };
}
