{ ... }:

{
  imports = [
    ./shells/zsh.nix
    ./browsers/firefox.nix
    ./wms/wlsunset.nix
    ./wms/dunst.nix
    ./wms/gtk.nix
    ./wms/waybar.nix
    ./wms/hyprlock.nix
    ./wms/hypridle.nix
    ./wms/ags.nix
    ./wms/gnome-keyring.nix
    ./wms/kanshi.nix
    ./wms/hyprland.nix
    ./defaults/tty.nix
    ./defaults/babUser.nix
    ./defaults/packages.nix
    ./defaults/git.nix
    ./colors.nix
    ./ssh/ssh.nix
    ./files.nix
    ./dev/js.nix
    ./dev/dotnet.nix
  ];
}
