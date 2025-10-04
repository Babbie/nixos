{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;

    font = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
      size = 11;
    };

    settings = {
      scrollback_lines = 10000;
    };
  };
}
