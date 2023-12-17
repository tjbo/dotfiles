$env.CONFIG_DIR = "~/.config/"
$env.NIXPKGS_DIR = "~/nixpkgs/"
$env.DOTFILES_DIR = "~/nixpkgs/dotfiles/"

$env.config = {
    edit_mode: vi 
  	history: {
		max_size: 3333
	}	
}




# change directories
alias cdc = cd $env.CONFIG_DIR
alias cddf = cd $env.DOTFILES_DIR
alias cdn = cd $env.NIXPKGS_DIR
alias cdv = cd $env.DOTFILES_DIR/nvim
alias cdz = cd $env.DOTFILES_DIR/zsh
alias cddt = cd ~Desktop
alias cddl = cd ~Downloads
alias cdp = cd ~projects
alias cdcl = cd ~projects/crescentlenders.com
alias cdpr = cd ~projects/prototypable.io
alias cdtl = cd ~projects/timer-labs-app
alias cdtla = cd ~projects/timer-labs-app/app
alias cdpp = cd ~projects/proxypack
alias cdtlf = cd ~projects/timer-labs-app/functions
alias cdtld = cd ~projects/timer-labs-app/db
alias cdtlv = cd ~projects/timer-labs-app/vpc
alias cdtlw = cd ~projects/timerlabs.com
alias cdtatw = cd ~projects/10adventures-web-front-end/src/componentstw
alias cdtac = cd ~projects/10adventures-web-front-end/src/components
alias cdta = cd ~projects/10adventures-web-front-end

# fast edit
alias e = nvim
alias ek = nvim $env.DOTFILES_DIR/kitty/kitty.conf
alias ez = nvim $env.DOTFILES_DIR/zsh/zsh.nix
alias eza = nvim $env.DOTFILES_DIR/zsh/zsh-aliases.nix
alias ev = nvim $env.DOTFILES_DIR/nvim/nvim.nix
alias evs = nvim $env.DOTFILES_DIR/nvim/settings.lua
alias es1 = nvim $env.NIXPKGS_DIR/darwin-configuration.nix
alias es2 = nvim $env.NIXPKGS_DIR/ubuntu/home.nix

# clear
alias c = clear

# git
alias g = lazygit
alias gs = git status

# better ls
alias ll = ls -l

# build systems
alias bs1 = darwin-rebuild switch and reload
alias bs2 = home-manager --file $env.NIXPKGS_DIR/ubuntu/home.nix switch

# alias reload = source ~/.zshrc

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

