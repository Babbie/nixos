{ inputs, lib, ... }:
{
  imports = [ 
    ./options.nix
  ];

  config = 
    let 
      mango = lib.getExe inputs.mango.packages."x86_64-linux".mango;
    in {
    displayManager = "greetd";
    programs.uwsm = {
      enable = true;
      waylandCompositors = {
        mango = {
          prettyName = "Mango";
          comment = "Mango compositor managed by UWSM";
          binPath = mango;
        };
      };
    };
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "uwsm start -- mango-uwsm.desktop > /dev/null";
          user = "bab";
        };
        default_session = initial_session;
      };
    };
  };
}
