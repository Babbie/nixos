{ pkgs, ... }:
{
  imports = [
    ./kdeconnect.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    vesktop
  ];
}
