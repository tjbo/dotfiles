let dotfiles_dir = "~/.config/dotfiles"; in
{
  # change directories
  "cda" = "cd ${dotfiles_dir}/alacritty";
  "cdc" = "cd ~/.config";
  "cddf" = "cd ${dotfiles_dir}";
  "cddf2" = "cd ~/.dotfiles";
  "cdn" = "cd ~/.nixpkgs";
  "cdv" = "cd ~/.config/dotfiles/nvim";
  "cdz" = "cd ~/.config/dotfiles/zsh";

  # fast edit
  "e" = "nvim";
  "ea" = "nvim ${dotfiles_dir}/alacritty/alacritty.nix";
  "ez" = "nvim ${dotfiles_dir}/zsh/zsh.nix";
  "eza" = "nvim ${dotfiles_dir}/zsh/zsh-aliases.nix";
  "ev" = "nvim ${dotfiles_dir}/nvim/nvim.nix";
  "evs" = "nvim ${dotfiles_dir}/nvim/settings.lua";
  "eh" = "nvim ${dotfiles_dir}/nixos/home.nix";
  "es" = "nvim ${dotfiles_dir}/nixos/configuration.nix";

  # git
  "g" = "lazygit";
  "gs" = "git status";

  # fast build
  # "bh" = "~/.config/dotfiles/rebuild-home.sh";
  "bs" = "darwin-rebuild switch";
}
