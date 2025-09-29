{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.kwallet
    kdePackages.kwallet-pam
  ];
  security.pam.services."${config.displayManager}".kwallet.enable = true;
}
