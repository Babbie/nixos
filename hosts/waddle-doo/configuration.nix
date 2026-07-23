{ inputs, ... }:
{
  imports = [
    ../default/configuration.nix
    ../default/laptop.nix

    inputs.hardware.nixosModules.lenovo-legion-16iah7h

    ./hardware-configuration.nix

    ../../dev/adb.nix
  ];

  config = {
    networking.hostName = "waddle-doo";

    home-manager = { 
      users.bab = import ./home.nix;
      extraSpecialArgs = { inherit inputs; };
    };

    system.stateVersion = "25.05";
  };
}

