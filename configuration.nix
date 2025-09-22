{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./rider.nix
      ./idea-flutter.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "waddle-dee";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "nl_NL.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_MONETARY = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
    };
  };

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.ly.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.bab = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "adbusers"
      "networkmanager"
      "wheel"
      "kvm"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim

    #KDE
    kdePackages.sddm-kcm
    wayland-utils
    wl-clipboard
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}

