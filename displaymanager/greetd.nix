{ inputs, pkgs, ... }:
{
  imports = [ 
    ./options.nix
  ];

  config = {
    displayManager = "greetd";
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${inputs.mango.packages."x86_64-linux".mango}/bin/mango";
          user = "bab";
        };
        default_session = initial_session;
      };
    };
  };
}
