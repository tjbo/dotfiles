alias ll = ls -l

alias cdc = cd $env.CONFIG_DIR
alias cddf = cd $env.DOTFILES_DIR
alias cdn = cd $env.NIXPKGS_DIR
alias cdl = cd ([$env.DOTFILES_DIR, "/lazygit"] | str join )
alias cdnu = cd ([$env.DOTFILES_DIR, "/nushell"] | str join )
alias cdv = cd ([$env.DOTFILES_DIR, "/nvim"] | str join )
alias cdz = cd ([$env.DOTFILES_DIR, "/zsh"] | str join )
alias cdp = cd ~/Projects


# build systems
alias bs1 = darwin-rebuild switch and reload
alias bs2 = home-manager --file ~/nixpkgs/ubuntu/home.nix switch

# yarn
alias yra = yarn run android
alias yrb = yarn run build
alias yrc = yarn run clean
alias yrd = yarn run develop
alias yri = yarn run ios
alias yrr = yarn run rescript
alias yrs = yarn run start
alias yrw = yarn run watch

# podfiles
alias pi = pod install

