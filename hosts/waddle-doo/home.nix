{ inputs, config, pkgs, ... }:

{
  imports = [
    ../default/home.nix

    ../../home/dev/rider.nix
    ../../home/applications/copilot.nix
  ];

  home.packages = with pkgs; [
    slack
    teams-for-linux
    postman
    ungoogled-chromium
  ];

  home.stateVersion = "25.05";
}
