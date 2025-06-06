# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ../../modules/nixos/imports.nix
    ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "waddle-doo"; # Define your hostname.

  home-manager.users."bab" = import ./home.nix;

  environment.systemPackages = [ pkgs.egl-wayland ];

  programs.adb.enable = true;
  babUser.extraGroups = [ "networkmanager" "wheel" "kvm" "adbusers" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
