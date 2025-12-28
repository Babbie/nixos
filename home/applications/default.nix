{ pkgs, ... }:
{
  imports = [
    ./kdeconnect.nix
    ./kitty.nix
    ./vesktop.nix
  ];

  home.packages = with pkgs; [
    proton-pass
  ];
}
