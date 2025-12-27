{ pkgs, config, ... }:
{
  home.shell.enableZshIntegration = true;
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      defaultKeymap = "viins";
      enableVteIntegration = true;
      shellAliases = {
        ll = "ls -l";
        np = "nix-shell --run zsh -p";
        nix-switch = "sudo nixos-rebuild switch --flake ~/.config/nixos#";
        nix-test = "sudo nixos-rebuild test --flake ~/.config/nixos#";
      };
      dirHashes = {
        nixos = "${config.home.homeDirectory}/.config/nixos";
      };

      setOptions = [
        "CDABLE_VARS"
        "AUTO_LIST"
      ];
    };
  };
}
