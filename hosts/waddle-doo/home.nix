{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/imports.nix
  ];

  zsh.enable = true;
  hyprland.enable = true;
  jsDev.enable = true;
  dotNetDev.enable = true;

  hyprland.env = [
    "LIBVA_DRIVER_NAME,nvidia"
    "XDG_SESSION_TYPE,wayland"
    "GBM_BACKEND,nvidia-drm"
    "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    "NVD_BACKEND,direct"
    "AQ_DRM_DEVICES,/dev/dri/card2:/dev/dri/card1"
  ];
  hyprland.exec-once = [
    "${pkgs.teams-for-linux}/bin/teams-for-linux"
    "${pkgs.slack}/bin/slack"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    teams-for-linux
    slack
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  userSsh.matchBlocks = {
    "github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
    };
    "github.com-babbie" = {
      hostname = "github.com";
      user = "git";
      identityFile = "${config.home.homeDirectory}/.ssh/babbie";
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
