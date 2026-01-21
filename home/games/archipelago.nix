{ pkgs, inputs, ... }:
let
  bizhawk = import inputs.bizhawk {
    forNixOS = true;
    inherit pkgs;
    dotnet-sdk_5 = pkgs.dotnet-sdk_6;
    gnome-themes-extra = pkgs.gnome-themes-extra;
  };
in {
  home.packages = with pkgs; [ 
    archipelago
    bizhawk.emuhawk-latest-bin
    mgba
    poptracker
  ];

  home.file."connector_bizhawkclient_mgba.lua" = {
    enable = true;
    source = ./connector_bizhawkclient_mgba.lua;
    target = ".local/share/Archipelago/data/lua/connector_bizhawkclient_mgba.lua";
  };
}
