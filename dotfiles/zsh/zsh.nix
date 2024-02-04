with import <nixpkgs> { };
{
  enableAutosuggestions = true;
  enableCompletion = true;
  syntaxHighlighting = {
    enable = true;
  };
  enable = true;
  enableVteIntegration = true;
  envExtra = ""; # extra commands to add to zshenv
  history = {
    expireDuplicatesFirst = true;
    extended = false;
    ignoreDups = true;
    ignorePatterns = [ "rm *" "pkill *" ];
    ignoreSpace = true;
    save = 1000;
    share = true;
    size = 1000;
  };
  initExtra = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH=~/.npm-packages/bin:$PATH
        export NODE_PATH=~/.npm-packages/lib/node_modules

        unsetopt beep
        autoload -U promptinit; promptinit
        prompt pure


        # fzf
        source ~/.config/zsh/fzf-bindings.zsh

        # load edit-command-line
        autoload -z edit-command-line
        zle -N edit-command-line

        # handles vi bindings for zsh
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        # keybinds
        export NODE_OPTIONS="--openssl-legacy-provider"
        export ANDROID_HOME=/Users/tjbo/Library/Android/sdk
        export PATH=$PATH:$ANDROID_HOME/emulator
        export PATH=$PATH:$ANDROID_HOME/platform-tools
  '';
  initExtraFirst = "";
  localVariables = {
    CASE_SENSITIVE = true;
    GIT_EDITOR = "nvim";
    EDITOR = "nvim";
    VISUAL = "nvim";
    FZF_DEFAULT_OPTS = "--height 100% --border";
    KEY_TIMEOUT = 1;
    PURE_PROMPT_SYMBOL = "=>";
    RPROMPT = "";
  };
  loginExtra = ""; # Extra commands that should be added to .zlogin.
  logoutExtra = ""; # Extra commands that should be added to .zlogout.
  profileExtra = ""; # Extra commands that should be added to .zprofile.
  shellAliases = import ./zsh-aliases.nix;
}
