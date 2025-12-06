{ inputs, config, pkgs, ... }:

{
  imports = [
    ../default/home.nix

    ../../home/dev/rider.nix
    ../../home/dev/idea-flutter.nix
    ../../home/games/default.nix
  ];

  home.stateVersion = "25.05";
}
