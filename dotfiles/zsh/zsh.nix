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
    # remove this line once we manage homebrew
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH=~/.npm-packages/bin:$PATH
    export NODE_PATH=~/.npm-packages/lib/node_modules
    export NODE_OPTIONS="--openssl-legacy-provider"
    export ANDROID_HOME=/Users/tjbo/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools

    unsetopt beep

    # pure prompt
    autoload -U promptinit; promptinit
    prompt pure

    # open command line text in vim
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd 'vv' edit-command-line

    # zsh plugins
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ${pkgs.fzf}/share/fzf/key-bindings.zsh

    # bind to fzf history search
    bindkey -M emacs '^H' fzf-history-widget
    bindkey -M vicmd '^H' fzf-history-widget
    bindkey -M viins '^H' fzf-history-widget

    # bind to auto suggest
    bindkey '^ ' autosuggest-accept
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
  loginExtra = "";
  logoutExtra = "";
  profileExtra = "";
  shellAliases = import ./zsh-aliases.nix;
}
