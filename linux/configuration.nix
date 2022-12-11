{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # ------------------------------------------------------------------------------
  # Bootloader 
  # ------------------------------------------------------------------------------  

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # ------------------------------------------------------------------------------
  # Networking 
  # ------------------------------------------------------------------------------  
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # ------------------------------------------------------------------------------
  # Misc Options 
  # ------------------------------------------------------------------------------  

  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # ------------------------------------------------------------------------------
  # Xserver 
  # ------------------------------------------------------------------------------  

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    xkbOptions = "capslock:escape,ctrl(swap_lwin_lctl)";
  };

# services.xserver.extraLayouts.us-greek = {
#   description = "US layout with alt-gr greek";
#   languages   = [ "eng" ];
#   symbolsFile = /home/tjbo/.config/dotfiles/xkb/symbols/us-greek;
# };



  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5 = {
    enable = true;

    # excludePackages  = [ pkgs.plasma5Packages.oxygen ];
  };

  # right now this doesn't work, but I may come back to bspwm eventually
  # services.xserver.windowManager.bspwm.configFile = /home/tjbo/.config/dotfiles/bspwm/bspwmrc;
  # services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap /home/tjbo/.config/xorg/xmodmap && sxhkd &";
  # services.xserver.windowManager.bspwm.sxhkd.configFile = builtins.getEnv "HOME" + "/.config/sxhkd/sxhkdrc";
  # services.xserver.windowManager.bspwm.enable = true;
  # services.xserver.displayManager.sessionCommands = "xmodmap /home/tjbo/.config/dotfiles/keyboard/xmodmap && sxhkd &";
  # powerManagement.resumeCommands = ''
  # xmodmap /home/tjbo/.config/dotfiles/keyboard/xmodmap && sxhkd &
  # '';
  # powerManagement.powerUpCommands = ''
  # xmodmap /home/tjbo/.config/dotfiles/keyboard/xmodmap && sxhkd &
  # '';
  #  services.xserver.windowManager.bspwm.sxhkd.configFile = /home/tjbo/.config/dotfiles/sxhkd/sxhkdrc;

  # ------------------------------------------------------------------------------
  # Printing 
  # ------------------------------------------------------------------------------  

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # ------------------------------------------------------------------------------
  # Sound 
  # ------------------------------------------------------------------------------  

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # ------------------------------------------------------------------------------
  # User 
  # ------------------------------------------------------------------------------  


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # set default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tjbo = {
    isNormalUser = true;
    description = "tjbo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # firefox
      # kate
      #  thunderbird
    ];
  };

  # ------------------------------------------------------------------------------
  # System Packages 
  # ------------------------------------------------------------------------------  

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  hardware.bluetooth.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    _1password-gui
    adapta-kde-theme
    arc-kde-theme
    bspwm
    # colloid-gtk-theme
    # colloid-icon-theme
    # colloid-kde
    # colloid-kde
    gcc
    gparted
    jumpapp
    # kde themes
    materia-kde-theme
    rofi
    spotify
    standardnotes
    sxhkd
    vivaldi
    vscode
    whatsapp-for-linux
    wl-clipboard
    xorg.xev
    xorg.xkbcomp
    xorg.xmodmap
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?



}


