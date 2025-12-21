{ inputs, config, pkgs, ... }:

{
  imports = [
    ../default/home.nix

    ../../home/dev/rider.nix
    ../../home/dev/idea-flutter.nix
  ];

  home.packages = with pkgs; [
    slack
    teams-for-linux
    postman
  ];

  home.stateVersion = "25.05";
}
