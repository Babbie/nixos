{ lib, config, ... }:
{
  options = {
    starship.color = lib.mkOption {
      type = lib.types.str;
      default = "blue";
      example = "green";
    };
  };

  config = {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;

      settings = lib.recursiveUpdate (import ./nerd-font-symbols.nix) {
        format = "[$status$directory $all" +
          "[](fg:${config.starship.color} inverted)" +
          "$line_break" +
          "$hostname" +
          "[](fg:${config.starship.color} inverted)" +
          "$username" +
          " ](fg:${config.starship.color})";

        status = {
          format = "[ $common_meaning$signal_name$maybe_int](inverted fg:red)[](fg:red)";
          disabled = false;
        };
        
        directory = {
          format = "[ $path$read_only]($style)";
          read_only = " 󰌾";
          style = "fg:cyan bold";
          fish_style_pwd_dir_length = 2;
        };

        username = {
          format = "[ $user](fg:${config.starship.color} inverted)";
        };

        hostname = {
          format = "[$ssh_symbol$hostname ](fg:${config.starship.color})";
          ssh_symbol = " ";
        };

        character.disabled = true;
        cmd_duration.disabled = true;
      };
    };
  };
}
