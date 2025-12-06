{ pkgs, ... }:
{
  home.packages = with pkgs; [ 
    archipelago
    mgba
    poptracker
  ];

  home.file."connector_bizhawkclient_mgba.lua" = {
    enable = true;
    source = ./connector_bizhawkclient_mgba.lua;
    target = ".local/share/Archipelago/data/lua/connector_bizhawkclient_mgba.lua";
  };
}
