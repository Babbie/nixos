{ config, ... }:
{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Name = config.networking.hostName;
      };
    };
  };
}
