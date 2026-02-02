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
    pwvucontrol
    yubioath-flutter
  ];

  programs = {
    bat.enable = true;
    feh.enable = true;
  };
}
