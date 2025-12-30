{ pkgs, lib, ... }:
let
  inherit (lib) mkOptionType mkOption importJSON;
  inherit (lib.strings) removePrefix;
  inherit (lib.types) attrsOf;
  inherit (builtins) isString isInt;
in {
  options = 
    let
      colors = mkOptionType {
        name = "Palette Colors";
        check = (x: 
          isString x.stripped &&
          isString x.hex &&
          isInt x.rgb.r &&
          isInt x.rgb.g &&
          isInt x.rgb.b
        );
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
      palette = lib.genAttrs (builtins.attrNames paletteFile) (p: 
        let 
          val = paletteFile.${p}; 
        in { 
          stripped = strip val.hex;
          hex = val.hex; 
          rgb = val.rgb;
        }
      );
    };
}
