{ pkgs, ... }:
{
  imports = [ ./options.nix ];

  config = {
    displayManager = "greetd";
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.mangowc}/bin/mango";
          user = "bab";
        };
        default_session = initial_session;
      };
    };
  };
}
