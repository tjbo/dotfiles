let dotfiles_dir = "~/.nixpkgs/dotfiles"; in
{
  # change directories
  "cda" = "cd ${dotfiles_dir}/alacritty";
  "cdc" = "cd ~/.config";
  "cddf" = "cd ${dotfiles_dir}";
  "cddf2" = "cd ~/.dotfiles";
  "cdn" = "cd ~/.nixpkgs";
  "cdv" = "cd ${dotfiles_dir}/dotfiles/nvim";
  "cdz" = "cd ${dotfiles_dir}/dotfiles/zsh";

  # fast edit
  "e" = "nvim";
  "ea" = "nvim ${dotfiles_dir}/alacritty/alacritty.nix";
  "ez" = "nvim ${dotfiles_dir}/zsh/zsh.nix";
  "eza" = "nvim ${dotfiles_dir}/zsh/zsh-aliases.nix";
  "ev" = "nvim ${dotfiles_dir}/nvim/nvim.nix";
  "evs" = "nvim ${dotfiles_dir}/nvim/settings.lua";
  "eh" = "nvim ${dotfiles_dir}/nixos/home.nix";
  "es" = "nvim ${dotfiles_dir}/nixos/configuration.nix";

  # clear
  "c" = "clear";

  # git
  "g" = "lazygit";
  "gs" = "git status";

  # better ls
  "ls" = "ls -AGFhoTl";

  # "bh" = "~/.config/dotfiles/rebuild-home.sh";
  "bs" = "darwin-rebuild switch";
}





## EDIT COMMON THINGS
#alias ezz="code $ZSH/.zshrc"
#alias eza="code $ZSH/.zaliasrc"
#alias ezv="code $VIM/.vimrc"
#alias ezvp="code $VIM/config/plugins.vim"
#alias ezs="code $SCRIPTS/symlinks.sh"

## HARDWARE SIMULATOR
#alias sim="~/Sites/nand2tetris/tools/HardwareSimulator.sh"

## ANDROID SHORCUTS
#alias ar="adb reverse tcp:8081 tcp:8081"
#alias ae="emulator -avd RNWebRTC"
#alias ar="adb reverse tcp:8081 tcp:8081"
#alias rni="react-native run-ios"
#alias rna="react-native run-android"

## DEV SHORTCUTS
#alias dd1="/Applications/Chromium.app/Contents/MacOS/Chromium --remote-debugging-port=9222"
#alias dd2="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9333"
#alias dda="open -a /Applications/Chromium.app/Contents/MacOS/Chromium http://helpscout.local.sumoci.net"
#alias dds="open -a /Applications/Chromium.app/Contents/MacOS/Chromium http://helpscout.local.sumoci.net/sumo"
#alias ddb="open -a /Applications/Chromium.app/Contents/MacOS/Chromium http://localhost:3001"

## CHANGE DIRECTORY COMMON
#alias cdc="cd ~/Projects/projects/packages/prototypable"
#alias cde="cd ~/Projects/projects/packages/eitherorelse.com"
#alias cda="cd ~/Projects/timer-labs-app/app"
#alias cdf="cd ~/Projects/timer-labs-app/functions"
#alias cds="cd ~/Projects/timer-labs-app/functions"
#alias cdt="cd ~/Projects/timer-labs-app/"
#alias cdw="cd ~/Projects/timer-labs-web"
#alias cdd="cd ~/Documents"
#alias cddl="cd ~/Downloads"
#alias cddb="cd ~/Dropbox/"
#alias cddf="cd ~/.dotfiles"
#alias cdssh="cd ~/.ssh/"
#alias cdv="cd $VIM"
#alias cdvc="cd $VIM/config"
#alias cdw="cd ~/Projects/writings"
#alias cdp="cd ~/Projects/"

## OPEN SHORTCUTS
#alias pp="npm run proxypack:open -- --browser=chromium"
#alias ppc="npm run proxypack:open -- --browser=chrome"
#alias ppf="npm run proxypack:open -- --browser=firefox"
#alias pps="npm run proxypack:open -- --browser=safari"

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
