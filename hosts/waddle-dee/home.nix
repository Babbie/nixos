{ inputs, config, pkgs, ... }:

{
  imports = [
    ../default/home.nix

    ../../home/dev/rider.nix
    ../../home/dev/idea-flutter.nix
    ../../home/games/default.nix
  ];

  config = {
    backlightDevice = "amdgpu_bl1";

    home.stateVersion = "25.05";
  };
}
