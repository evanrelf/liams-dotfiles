
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix 
      ./firefox.nix
      ./apps.nix
      ./zsh.nix
      ./tmux.nix
      # ./vim.nix
      ./nixvim.nix
    ];

  # Basic Setup.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "liam-tpad"; 
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.enable = true;
  services.libinput.enable = true;
  services.printing.enable = true;
  users.users.liam = {
    isNormalUser = true;
    description = "liam";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ];
    packages = with pkgs; [
    ];
  };

  users.users.liam.shell = pkgs.zsh ;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  programs.virt-manager.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
          General = {
          Experimental = true;
          FastConnectable = true;
        };
    Policy = {
      AutoEnable = true;
    };
  };
        };

  # Graphics
  hardware.graphics = {
      enable = true;
      #extraPackages = with pkgs; [
          #intel-media-driver
          #intel-compute-runtime
          #vpl-gpu-rt
        #];
    };
  services.displayManager.ly.enable = true;
  programs.hyprland.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

 # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:ctrl_modifier";
  };
 
 # Splash screen
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";

 # Enable doas instead of sudo
    security.sudo.enable = false;
    security.doas.enable = true;
    security.doas.extraRules = [{
	users = [ "liam" ];
	keepEnv = true;
        persist = true;
     }];

 # power
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

fonts.packages = with pkgs; [
      nerd-fonts.ubuntu
      ubuntu-sans
      ubuntu-classic
      ubuntu-sans-mono
      departure-mono
      nerd-fonts.lekton
      nerd-fonts.anonymice
      nerd-fonts.caskaydia-cove
      fantasque-sans-mono
        ];

 # Don't change this lol
  system.stateVersion = "25.05"; # Did you read the comment?

}

