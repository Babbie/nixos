{
  programs = {
    nushell = {
      enable = true;
      settings = {
        edit_mode = "vi";
        show_banner = false;
        rm.always_trash = true;
        completions = {
          algorithm = "fuzzy";
        };
        use_kitty_protocol = true;
        display_errors.termination_signal = false;
      };
      envFile.text = ''
        $env.PROMPT_INDICATOR_VI_NORMAL = "\e[1;30mN "
        $env.PROMPT_INDICATOR_VI_INSERT = ""
      '';
      shellAliases = {
        ll = "ls -l";
        np = "nix-shell --run nushell -p";
        nix-switch = "sudo nixos-rebuild switch --flake ~/.config/nixos#";
        nix-test = "sudo nixos-rebuild test --flake ~/.config/nixos#";
      };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
