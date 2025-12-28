{ inputs, pkgs, ... }:
{
  imports = [
    ../kanshi.nix
    ../cursor.nix
    ../portal.nix
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
