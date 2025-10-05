{ pkgs, ... }:
{
  imports = [ ./options.nix ];

  config = {
    displayManager = "greetd";
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.kdePackages.plasma-workspace}/bin/startplasma-wayland";
          user = "bab";
        };
        default_session = initial_session;
      };
    };
  };
}
