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
    ./defaults/git.nix
    ./defaults/packages.nix
    ./colors.nix
    ./ssh/ssh.nix
    ./files.nix
  ];
}
