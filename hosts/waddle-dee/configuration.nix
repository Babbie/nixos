{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../../misc/adb.nix
    ../../system/bluetooth.nix
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
    displayManager.ly = {
      enable = true;
      x11Support = false;
    };
  };

  security.pam.services.ly.kwallet.enable = true;

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages= true;
    users.bab = import ./home.nix;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
  };

  environment.systemPackages = with pkgs; [
    neovim

    wayland-utils
    wl-clipboard
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}

