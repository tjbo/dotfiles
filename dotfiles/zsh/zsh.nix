with import <nixpkgs> {};
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
    save = 20000;
    share = true;
    size = 10000;
  };
  initExtra = ''
    autoload -U promptinit; promptinit
    prompt pure
    # handles vim bindings
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    source "$(fzf-share)/completion.zsh"
    source "/Users/tjbo/.config/zsh/fzf-bindings.zsh"
    '';
  initExtraFirst = "";
  localVariables = {
    # this breaks lazy git
    # TERMINFO="/Users/tjbo/.config/iterm2/terminfo.src";
    # TERM = "iterm2"; 
    EDITOR = "nvim";
    PURE_PROMPT_SYMBOL = "=>";
    CASE_SENSITIVE = true;
    KEY_TIMEOUT = 1;
    RPROMPT = "";
    FZF_DEFAULT_OPTS="--height 100% --border";
  }; # Extra local variables defined at the top of .zshrc.
  loginExtra = ""; # Extra commands that should be added to .zlogin.
  logoutExtra = ""; # Extra commands that should be added to .zlogout.
  profileExtra = ""; # Extra commands that should be added to .zprofile.
  shellAliases = import ./zsh-aliases.nix;
}
