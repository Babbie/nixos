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
    ./dev/js.nix
    ./files.nix
    ./shells/zsh.nix
    ./ssh/ssh.nix
    ./wms/ags.nix
    ./wms/dunst.nix
    ./wms/gnome-keyring.nix
    ./wms/gtk.nix
    ./wms/hypridle.nix
    ./wms/hyprland.nix
    ./wms/hyprlock.nix
    ./wms/kanshi.nix
    ./wms/waybar.nix
    ./wms/wlsunset.nix
  ];
}
