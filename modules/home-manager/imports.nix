{ ... }:

{
  imports = [
    ./shells/zsh.nix
    ./browsers/firefox.nix
    ./wms/wlsunset.nix
    ./wms/dunst.nix
    ./wms/waybar.nix
    ./wms/gtk.nix
    ./wms/kanshi.nix
    ./wms/hyprland.nix
    ./defaults/tty.nix
    ./defaults/git.nix
    ./defaults/packages.nix
    ./defaults/babUser.nix
    ./colors.nix
    ./ssh/ssh.nix
    ./files.nix
  ];
}
