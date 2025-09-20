{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    audio.enable = mkOption {
      default = true;
      description = "Enable default audio settings";
    };
  };

  config = mkIf config.audio.enable {
    environment.systemPackages = [ pkgs.pulseaudio ];
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
