{ pkgs, lib, ... }:
let
  inherit (lib) mkOptionType mkOption importJSON;
  inherit (lib.strings) removePrefix;
  inherit (lib.types) attrsOf;
  inherit (builtins) isString;
in {
  options = 
    let
      colors = mkOptionType {
        name = "Palette Colors";
        check = x: isString x.stripped && isString x.hex;
      };
    in {
      palette = mkOption { type = attrsOf colors; };
    };

  config = 
    let
      flavor = "macchiato";
      paletteFile = (importJSON "${pkgs.catppuccin}/palette/palette.json").${flavor}.colors;
      strip = removePrefix "#";
    in {
      palette = lib.genAttrs (builtins.attrNames paletteFile) ( 
        p: { 
          stripped = strip paletteFile.${p}.hex;
          hex = paletteFile.${p}.hex; 
        }
      );
    };
}
