{ ... }:

{
  imports = [
    ./shells/zsh.nix
    ./browsers/firefox.nix
    ./wms/wlsunset.nix
    ./wms/dunst.nix
    ./wms/gtk.nix
    ./wms/hyprlock.nix
    ./wms/hypridle.nix
    ./wms/ags.nix
    ./wms/gnome-keyring.nix
    ./wms/kanshi.nix
    ./wms/hyprland.nix
    ./wms/waybar.nix
    ./defaults/babUser.nix
    ./defaults/git.nix
    ./defaults/packages.nix
    ./defaults/tty.nix
    ./colors.nix
    ./ssh/ssh.nix
    ./files.nix
    ./dev/js.nix
    ./dev/azure.nix
    ./dev/dotnet.nix
    ./dev/flutter.nix
  ];
}
