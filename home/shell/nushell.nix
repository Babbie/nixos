{
  programs = {
    nushell = {
      enable = true;
      settings = {
        edit_mode = "vi";
      };
      extraConfig = ''
        let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
        }
        $env.PROMPT_INDICATOR_VI_NORMAL = "\e[1;30mN "
        $env.PROMPT_INDICATOR_VI_INSERT = ""
        $env.config = {
          completions: {
            external: {
              completer: $carapace_completer
            }
          }
        }
      '';
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
