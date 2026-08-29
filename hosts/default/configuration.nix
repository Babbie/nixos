{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../boot
    ../../system
    ../../displaymanager
    ../../firewall
  ];

  config = with lib; {
    boot = {
      loader.systemd-boot.enable = mkDefault true;
      loader.efi.canTouchEfiVariables = mkDefault true;
      tmp.cleanOnBoot = true;
    };

    networking.networkmanager.enable = mkDefault true;

    time.timeZone = mkDefault "Europe/Amsterdam";

    i18n = mkDefault {
      defaultLocale = "en_US.UTF-8";
      extraLocales = ["nl_NL.UTF-8/UTF-8"];
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
      pipewire = {
        enable = mkDefault true;
        pulse.enable = mkDefault true;
      };
      # yubikey
      pcscd.enable = true;
      udev.packages = [pkgs.yubikey-personalization];
    };

    security.polkit.enable = true;

    # AppImages
    programs = {
      appimage = {
        enable = true;
        binfmt = true;
      };
      direnv.enable = true;
      zsh.enable = true;
    };

    fonts.enableDefaultPackages = true;
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.fira-code
    ];

    catppuccin = rec {
      enable = mkDefault true;
      autoEnable = enable;
      cache.enable = true;
      accent = mkDefault "blue";
      flavor = mkDefault "macchiato";
    };

    users.users.bab = {
      isNormalUser = mkDefault true;
      shell = pkgs.zsh;
      extraGroups = mkDefault [
        "adbusers"
        "networkmanager"
        "wheel"
        "kvm"
      ];
    };

    environment = {
      # ZSH autocomplete paths
      pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
        "/share/zsh"
      ];
      variables.EDITOR = "nvim";
      systemPackages = with pkgs; [
        bash
        neovim
        nix-tree
        wayland-utils
        wl-clipboard
      ];
    };

    home-manager = {
      useGlobalPkgs = mkDefault true;
      useUserPackages = mkDefault true;
      backupFileExtension = mkDefault "backup";
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = ["electron-40.10.5"];
    };
  };
}
