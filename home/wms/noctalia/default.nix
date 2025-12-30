{ inputs, config, ... }:
{
  imports = [
    ../../../util/palette.nix
  ];
  config =
    let 
      pkg = inputs.noctalia.packages."x86_64-linux".default; 
    in {
      home.packages = [ pkg ];
      home.file = {
        "colorscheme" = {
          enable = false;
          target = ".config/noctalia/colorschemes/Catppuccin Macchiato/Catppuccin Macchiato.json";
          text = with config.palette; ''
            {
              "dark": {
                  "mPrimary": "${rosewater.hex}",
                  "mOnPrimary": "${crust.hex}",
                  "mSecondary": "${teal.hex}",
                  "mOnSecondary": "${crust.hex}",
                  "mTertiary": "${mauve.hex}",
                  "mOnTertiary": "${crust.hex}",
                  "mError": "${red.hex}",
                  "mOnError": "${crust.hex}",
                  "mSurface": "${base.hex}",
                  "mOnSurface": "${text.hex}",
                  "mSurfaceVariant": "${surface0.hex}",
                  "mOnSurfaceVariant": "${text.hex}",
                  "mOutline": "${surface1.hex}",
                  "mShadow": "${crust.hex}",
                  "mHover": "${lavender.hex}",
                  "mOnHover": "${crust.hex}"
              },
              "light": {
                  "mPrimary": "#8839ef",
                  "mOnPrimary": "#eff1f5",
                  "mSecondary": "#fe640b",
                  "mOnSecondary": "#eff1f5",
                  "mTertiary": "#40a02b",
                  "mOnTertiary": "#eff1f5",
                  "mError": "#d20f39",
                  "mOnError": "#dce0e8",
                  "mSurface": "#eff1f5",
                  "mOnSurface": "#4c4f69",
                  "mSurfaceVariant": "#ccd0da",
                  "mOnSurfaceVariant": "#6c6f85",
                  "mOutline": "#a5adcb",
                  "mShadow": "#dce0e8",
                  "mHover": "#40a02b",
                  "mOnHover": "#eff1f5"
              }
            }
          '';
        };
      };
    };
}
