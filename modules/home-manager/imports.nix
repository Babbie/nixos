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
    ./wms/hyprlock.nix
    ./wms/hypridle.nix
    ./wms/hyprland.nix
    ./wms/ags.nix
    ./wms/ags/tsconfig.json
    ./wms/ags/README.md
    ./wms/ags/ts/main.ts
    ./wms/ags/config.js
    ./wms/README.md
    ./defaults/tty.nix
    ./defaults/babUser.nix
    ./defaults/packages.nix
    ./defaults/git.nix
    ./colors.nix
    ./ssh/ssh.nix
    ./files.nix
    ./dev/js.nix
  ];
}
