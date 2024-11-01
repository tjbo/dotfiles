let
  dotfiles_dir = "~/dotfiles/dotfiles";
  config_dir = "~/.config";
  nixpkgs_dir = "~/dotfiles";
in
{
  # change directories
  "cdb" = "cd ../";
  "cdc" = "cd ${config_dir}";
  "cde" = "cd ~/Projects/eitherorelse.com";
  "cddf" = "cd ${dotfiles_dir}";
  "cdn" = "cd ${nixpkgs_dir}";
  "cdv" = "cd ${dotfiles_dir}/nvim";
  "cdz" = "cd ${dotfiles_dir}/zsh";
  "cddt" = "cd ~/Desktop";
  "cddl" = "cd ~/Downloads";
  "cdp" = "cd ~/Projects/";
  "cdpp" = "cd ~/Projects/prep";
  "cdcl" = "cd ~/Projects/crescentlenders.com/";
  "cdpr" = "cd ~/Projects/prototypable.io/";
  "cdtl" = "cd ~/Projects/timer-labs-app/";
  "cdtla" = "cd ~/Projects/timer-labs-app/app";
  "cdtlf" = "cd ~/Projects/timer-labs-app/functions2";
  "cdtq" = "cd ~/Projects/tq/paperbits-cms/";
  "cdtqf" = "cd ~/Projects/tq/tq-cms-functions";
  "cdtqb" = "cd ~/Projects/tq/paperbits-cms/";
  "cdma" = "cd ~/Projects/tq/paperbits-cms/microapps/";
  "cdtqc" = "cd ~/Projects/tq/paperbits-cms/components/";

  "cdtld" = "cd ~/Projects/timer-labs-app/db";
  "cdtlv" = "cd ~/Projects/timer-labs-app/vpc";
  "cdtlw" = "cd ~/Projects/timerlabs.com/";
  "cdtatw" = "cd ~/Projects/10adventures-web-front-end/src/componentstw/";
  "cdtac" = "cd ~/Projects/10adventures-web-front-end/src/components";
  "cdta" = "cd ~/Projects/10adventures-web-front-end";

  # fast edit
  "e" = "nvim";
  "ek" = "nvim ${dotfiles_dir}/kitty/kitty.conf";
  "ez" = "nvim ${dotfiles_dir}/zsh/zsh.nix";
  "eza" = "nvim ${dotfiles_dir}/zsh/zsh-aliases.nix";
  "ev" = "nvim ${dotfiles_dir}/nvim/nvim.nix";
  "evs" = "nvim ${dotfiles_dir}/nvim/settings.lua";
  "es1" = "nvim ${nixpkgs_dir}/macosx/home.nix";
  "es2" = "nvim ${nixpkgs_dir}/ubuntu/home.nix";

  # clear
  "c" = "clear";

  # git
  "g" = "lazygit";
  "gs" = "git status";

  # better ls
  "ls" = "ls -AGFhol";

  # build systems
  "bs1" = "export NIXPKGS_ALLOW_UNFREE=1 && home-manager switch -f ${nixpkgs_dir}/macosx/home.nix && reload";
  "bs2" = "home-manager --file ${nixpkgs_dir}/ubuntu/home.nix switch";

  "reload" = "source ~/.zshrc";

  "yra" = "yarn run android";
  "yrb" = "yarn run build";
  "yrc" = "yarn run clean";
  "yrd" = "yarn run develop";
  "yri" = "yarn run ios";
  "yrr" = "yarn run rescript";
  "yrs" = "yarn run start";
  "yrw" = "yarn run watch";

  # podfiles
  "pi" = "pod install";
}
