let
  dotfiles_dir = "~/.nixpkgs/dotfiles";
  config_dir = "~/.config";
  nixpkgs_dir = "~/.nixpkgs";
in
{
  # change directories
  "cda" = "cd ${dotfiles_dir}/alacritty";
  "cdb" = "cd ../";
  "cdc" = "cd ${config_dir}";
  "cddf" = "cd ${dotfiles_dir}";
  "cddf2" = "cd ~/.dotfiles";
  "cdhttag" = "cd ~/Projects/howtotuneaguitar.org";
  "cdn" = "cd ${nixpkgs_dir}";
  "cdv" = "cd ${dotfiles_dir}/nvim";
  "cdz" = "cd ${dotfiles_dir}/zsh";
  "cddt" = "cd ~/Desktop";
  "cddl" = "cd ~/Downloads";
  "cdp" = "cd ~/Projects/";
  "cdcl" = "cd ~/Projects/crescentlenders.com/";
  "cdpr" = "cd ~/Projects/prototypable.io/";
  "cdtl" = "cd ~/Projects/timer-labs-app/";
  "cdtla" = "cd ~/Projects/timer-labs-app/app";
  "cdpp" = "cd ~/Projects/proxypack/";
  "cdtlf" = "cd ~/Projects/timer-labs-app/functions";
  "cdtld" = "cd ~/Projects/timer-labs-app/db";
  "cdtlv" = "cd ~/Projects/timer-labs-app/vpc";
  "cdtlw" = "cd ~/Projects/timerlabs.com/";
  "cdvw" = "cd ~/vimwiki";

  # fast edit
  "e" = "nvim";
  "ea" = "nvim ${dotfiles_dir}/alacritty/alacritty.nix";
  "ek" = "nvim ${dotfiles_dir}/kitty/kitty.conf";
  "ez" = "nvim ${dotfiles_dir}/zsh/zsh.nix";
  "eza" = "nvim ${dotfiles_dir}/zsh/zsh-aliases.nix";
  "ev" = "nvim ${dotfiles_dir}/nvim/nvim.nix";
  "evs" = "nvim ${dotfiles_dir}/nvim/settings.lua";
  "eh" = "nvim ${dotfiles_dir}/nixos/home.nix";
  "es" = "nvim ${dotfiles_dir}/nixos/configuration.nix";
  "ed" = "nvim ${nixpkgs_dir}/darwin-configuration.nix";

  # clear
  "c" = "clear";

  # git
  "g" = "lazygit";
  "gs" = "git status";

  # better ls
  "ls" = "ls -AGFhoTl";

  # "bh" = "~/.config/dotfiles/rebuild-home.sh";
  "bs" = "darwin-rebuild switch && reload";

  "reload" = "source ~/.zshrc";
  "rni" = "react-native run-ios";

  "yra" = "yarn run android";
  "yrb" = "yarn run build";
  "yrc" = "yarn run clean";
  "yrd" = "yarn run develop";
  "yri" = "yarn run ios";
  "yrr" = "yarn run rescript";
  "yrs" = "yarn run start";

  # podfiles
  "pi" = "pod install";
}


#alias rna="react-native run-android"


## NPM
#alias ni="npm install"
#alias nip="npm install --package-lock-only"
#function ns() {
#      if [ "$PWD" = "/Users/tjbo/Projects/hs-app" ]; then
#        npm run proxypack:start:log
#      elif [ "$PWD" = "/Users/tjbo/Projects/hsds" ]; then
#        npm run start
#      elif [ "$PWD" = "/Users/tjbo/Projects/beacon2" ]; then
#        npm run start:prod -- --id 579f9900-6d70-41b8-ac8c-cdff13612bfd
#      elif [ "$PWD" = "/Users/tjbo/Projects/eitherorelse.com" ]; then
#        eleventy --serve
#      else
#        npm run start
#      fi
#}

## YARN
#alias yrc="yarn run clean"
#alias yrd="yarn run develop"
#alias yrs="yarn run start"
#alias yre="yarn run electron"
#alias yrr="yarn run rescript"
#alias yri="yarn run ios"
#alias yra="yarn run android"
#alias yrb="yarn run build"
#alias yrbd="yarn run build:data"
#alias yrbdp="yarn run build:data:prismic"
#alias yrbdg="yarn run build:data:graphql"
#alias yrsb="yarn run storybook"
#alias yrh="yarn run serve"
#alias yrt="yarn run test"


## GIT GET
#alias gs="git status"
#alias gr="git reset --hard HEAD"
#alias gb="git for-each-ref --sort=committerdate refs/heads/"

## VSCODE SHORTCUT
#alias code='open $@ -a "Visual Studio Code"'
#alias c='open $@ -a "Visual Studio Code"'

##OCTAVE SHORTCUT
#alias o='octave'

#alias python=/usr/local/bin/python3.8
