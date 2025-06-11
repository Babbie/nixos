{ ... }:

{
  imports = [
    ./defaults/babUser.nix
    ./defaults/locale.nix
    ./defaults/plymouth.nix
    ./defaults/networkmanager.nix
    ./defaults/sudo.nix
    ./defaults/greetd.nix
    ./defaults/homeManagerDefaults.nix
    ./defaults/audio.nix
    ./defaults/bluetooth.nix
    ./defaults/autoUpgrade.nix
    ./defaults/gnome-keyring.nix
    ./defaults/packages.nix
    ./defaults/defaultBoot.nix
    ./defaults/misc.nix
  ];
}
