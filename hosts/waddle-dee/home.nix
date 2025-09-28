{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  home.username = "bab";
  home.homeDirectory = "/home/bab";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
  ];

  programs.git.enable = true;
  programs.zen-browser.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
