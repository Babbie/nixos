{ pkgs, ... }:
{
  imports = [
    ./kdeconnect.nix
    ./kitty.nix
    ./vesktop.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    proton-pass
  ];

  programs = {
    bat.enable = true;
    feh.enable = true;
  };
}
