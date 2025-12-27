{ inputs, pkgs, ... }:
{
  imports = [
    ../kanshi.nix
    inputs.mango.hmModules.mango
  ];
  config = {
    home.packages = [ pkgs.mangowc ];
    #wayland.windowManager.mango = {
    #  enable = true;
    #  settings = ''

    #  '';
    #  autostart_sh = ''

    #  '';
    #};
  };
}
