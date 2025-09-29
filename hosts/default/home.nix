{ inputs, lib, pkgs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  config = with lib; {
    home.username = mkDefault "bab";
    home.homeDirectory = mkDefault "/home/bab";

    # Packages that should be installed to the user profile.
    home.packages = with pkgs; [
    ];

    programs.git.enable = true;
    programs.zen-browser.enable = mkDefault true;
  };
}
