{ config, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Name = config.networking.hostName;
      };
    };
  };
  
  services.blueman.enable = true;
}
