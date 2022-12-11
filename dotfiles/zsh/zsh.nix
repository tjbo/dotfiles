with import <nixpkgs> {};
{
  dotDir = ".config/zsh";
  enableAutosuggestions = true;
  enableCompletion = true;
  enableSyntaxHighlighting = true;
  enable = true;
  enableVteIntegration = true;
  envExtra = ""; # extra commands to add to zshenv
  history = {
    expireDuplicatesFirst = true;
    extended = false;
    ignoreDups = true;
    ignorePatterns = [ "rm *" "pkill *" ];
    ignoreSpace = true;
    path = "/home/tjbo/.config/zsh/.zsh_history";
    save = 20000;
    share = true;
    size = 10000;
  };
  initExtra = ''
    prompt pure 
    # handles vim bindings
    source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  initExtraFirst = "autoload -U promptinit";
  localVariables = {
    EDITOR = "nvim";
    PURE_PROMPT_SYMBOL = "=>";
    CASE_SENSITIVE = true;
    KEY_TIMEOUT = 1;
  }; # Extra local variables defined at the top of .zshrc.
  loginExtra = ""; # Extra commands that should be added to .zlogin.
  logoutExtra = ""; # Extra commands that should be added to .zlogout.
  profileExtra = ""; # Extra commands that should be added to .zprofile.
  shellAliases = import ./zsh-aliases.nix;
}
