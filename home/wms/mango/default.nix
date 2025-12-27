{ inputs, pkgs, ... }:
{
  imports = [
    ./mango.nix
  ];
  config = {
    home.packages = [ inputs.noctalia.packages."x86_64-linux".default ];
  };
}
