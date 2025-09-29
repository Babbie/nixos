{ lib, config, ... }:
{
  imports = [ ./options.nix ];

  config = {
    displayManager = "ly";
    services.displayManager."ly" = {
      enable = true;
      x11Support = false;
    };
  };
}
