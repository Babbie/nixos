{ config, lib, pkgs, ... }:

with lib; {
  options = {
    wlsunset.enable = mkEnableOption "wlsunset blue light filter";
  };

  config = mkIf config.wlsunset.enable {
    services.wlsunset = {
      enable = true;
      latitude = "53.2";
      longitude = "6.6";
      temperature.day = 6500;
      temperature.night = 2500;
    };
  };
}
