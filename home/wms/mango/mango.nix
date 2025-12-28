{ inputs, pkgs, ... }:
{
  imports = [
    ../kanshi.nix
    inputs.mango.hmModules.mango
  ];
  config = {
    wayland.windowManager.mango = {
      enable = true;
    #  settings = ''

    #  '';
    };
  };
}
