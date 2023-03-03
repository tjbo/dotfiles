with import <nixpkgs> { };
{
  # dotDir = "/Users/tjbo/.config/zsh/";
  enableAutosuggestions = true;
  enableCompletion = true;
  enableSyntaxHighlighting = true;
  enable = true;
  enableVteIntegration = true;
  envExtra = ""; # extra commands to add to zshenv
  history = {
    expireDuplicatesFirst = true;
    extended = false;
    # path = "/Users/tjbo/.config/zsh/.zsh_history";
    ignoreDups = true;
    ignorePatterns = [ "rm *" "pkill *" ];
    ignoreSpace = true;
    save = 1000;
    share = true;
    size = 1000;
  };
  initExtra = ''
    autoload -U promptinit; promptinit
    prompt pure

    # handles vim bindings for zsh
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

    # fzf
    source "$(fzf-share)/completion.zsh"
    source "/Users/tjbo/.config/zsh/fzf-bindings.zsh"
    
    export NODE_OPTIONS="--openssl-legacy-provider"

    export ANDROID_HOME=/Users/tjbo/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/platform-tools

    # can move this
    source $HOME/.cargo/env
  '';
  initExtraFirst = "";
  localVariables = {
    CASE_SENSITIVE = true;
    EDITOR = "nvim";
    FZF_DEFAULT_OPTS = "--height 100% --border";
    KEY_TIMEOUT = 1;
    VIFM = "/Users/tjbo/.config/vifm/";
    MYVIFMRC = "/Users/tjbo/.config/vifm/vifmrc";
    PURE_PROMPT_SYMBOL = "=>";
    RPROMPT = "";
  }; # Extra local variables defined at the top of .zshrc.
  loginExtra = ""; # Extra commands that should be added to .zlogin.
  logoutExtra = ""; # Extra commands that should be added to .zlogout.
  profileExtra = ""; # Extra commands that should be added to .zprofile.
  shellAliases = import ./zsh-aliases.nix;
}
