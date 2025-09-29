{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../../system
    ../../displaymanager
    ../../secretservice
  ];

  config = with lib; {
    boot.loader.systemd-boot.enable = mkDefault true;
    boot.loader.efi.canTouchEfiVariables = mkDefault true;

    networking.networkmanager.enable = mkDefault true;

    time.timeZone = mkDefault "Europe/Amsterdam";

    i18n = mkDefault {
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

    services.pipewire = {
      enable = mkDefault true;
      pulse.enable = mkDefault true;
    };

    users.users.bab = {
      isNormalUser = mkDefault true;
      createHome = mkDefault true;
      extraGroups = mkDefault [
        "adbusers"
        "networkmanager"
        "wheel"
        "kvm"
      ];
    };

    home-manager = {
      useGlobalPkgs = mkDefault true;
      useUserPackages= mkDefault true;
      backupFileExtension = mkDefault "backup";
    };

    environment.systemPackages = with pkgs; [
      neovim

      wayland-utils
      wl-clipboard
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
  };
}

