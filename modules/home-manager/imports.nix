{ ... }:

{
  imports = [
    ./shells/zsh.nix
    ./browsers/firefox.nix
    ./wms/wlsunset.nix
    ./wms/dunst.nix
    ./wms/gtk.nix
    ./wms/kanshi.nix
    ./wms/waybar.nix
    ./wms/hypridle.nix
    ./wms/hyprlock.nix
    ./wms/hyprland.nix
    ./defaults/tty.nix
    ./defaults/git.nix
    ./defaults/babUser.nix
    ./defaults/packages.nix
    ./colors.nix
    ./ssh/ssh.nix
    ./files.nix
  ];
}
