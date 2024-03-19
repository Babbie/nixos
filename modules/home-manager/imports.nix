{ ... }:

{
  imports = [
    ./shells/zsh.nix
    ./browsers/firefox.nix
    ./wms/wlsunset.nix
    ./wms/dunst.nix
    ./wms/waybar.nix
    ./wms/gtk.nix
    ./wms/hyprland.nix
    ./defaults/babUser.nix
    ./defaults/tty.nix
    ./defaults/packages.nix
    ./defaults/git.nix
    ./colors.nix
  ];
}
