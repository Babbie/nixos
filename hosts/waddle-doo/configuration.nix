{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../default/configuration.nix

    inputs.hardware.nixosModules.lenovo-legion-16iah7h
    inputs.mango.nixosModules.mango

    ./hardware-configuration.nix

    ../../dev/adb.nix
  ];

  config = {
    networking.hostName = "waddle-doo";

    services = {
      desktopManager.plasma6.enable = true;
    };

    programs.mango.enable = true;

    home-manager = { 
      users.bab = import ./home.nix;
      extraSpecialArgs = { inherit inputs; };
    };

    system.stateVersion = "25.05";
  };
}

