{
  programs = {
    nushell = {
      enable = true;
      settings = {
        edit_mode = "vi";
        show_banner = false;
        always_trash = true;
        completions = {
          algorithm = "fuzzy";
        };
        use_kitty_protocol = true;
        termination_signal = false;
      };
      extraConfig = ''
        $env.PROMPT_INDICATOR_VI_NORMAL = "\e[1;30mN "
        $env.PROMPT_INDICATOR_VI_INSERT = ""
      '';
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
