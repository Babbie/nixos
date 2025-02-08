{ ... }:

{
  imports = [
    ./browsers/firefox.nix
    ./colors.nix
    ./defaults/babUser.nix
    ./defaults/git.nix
    ./defaults/packages.nix
    ./defaults/tty.nix
    ./dev/dotnet.nix
    ./dev/azure.nix
    ./dev/flutter.nix
    ./dev/js.nix
    ./files.nix
    ./shells/zsh.nix
    ./ssh/ssh.nix
    ./wms/dunst.nix
    ./wms/hypridle.nix
    ./wms/waybar.nix
    ./wms/wlsunset.nix
    ./wms/gtk.nix
    ./wms/hyprlock.nix
    ./wms/ags.nix
    ./wms/gnome-keyring.nix
    ./wms/kanshi.nix
    ./wms/hyprland.nix
  ];
}
