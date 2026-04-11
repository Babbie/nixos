{ pkgs, ... }:
{
  home.packages = with pkgs; [ 
    (retroarch.withCores (cores: with cores; [
      mgba
      melonds
      beetle-psx-hw
    ]))
  ];
}
