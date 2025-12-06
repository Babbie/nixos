{ pkgs, ... }:
{
  home.packages = with pkgs; [ 
    archipelago
    mgba
    poptracker
  ];
}
