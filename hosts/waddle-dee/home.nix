{ inputs, config, pkgs, ... }:
{
  imports = [
    ../default/home.nix

    ../../home/games/default.nix
  ];

  backlightDevice = "amdgpu_bl1";

  home.stateVersion = "25.05";
}
