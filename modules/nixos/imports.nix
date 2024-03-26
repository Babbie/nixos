{ ... }:

{
  imports = [
    ./defaults/babUser.nix
    ./defaults/locale.nix
    ./defaults/plymouth.nix
    ./defaults/defaultBoot.nix
    ./defaults/networkmanager.nix
    ./defaults/sudo.nix
    ./defaults/greetd.nix
    ./defaults/homeManagerDefaults.nix
    ./defaults/audio.nix
    ./defaults/bluetooth.nix
    ./defaults/misc.nix
    ./defaults/packages.nix
  ];
}
