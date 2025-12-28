{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../default/configuration.nix

    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../../dev/adb.nix
  ];

  config = {
    networking.hostName = "waddle-dee";

    home-manager = { 
      users.bab = import ./home.nix;
      extraSpecialArgs = { inherit inputs; };
    };

    system.stateVersion = "25.05";
  };
}

