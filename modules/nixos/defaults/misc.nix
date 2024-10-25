{ lib, config, pkgs, ... }:

with lib; {
  imports = [
  ];

  options = {
    miscDefaults.enable = mkOption {
      default = true;
      description = "Enable misc NixOS setting defaults";
    };
  };

  config = mkIf config.miscDefaults.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
      randomizedDelaySec = "1h";
    };
    programs.dconf.enable = true;
    nixpkgs.config.allowUnfree = true;
    home-manager.useGlobalPkgs = true;
    hardware.graphics.enable = true;
    security.polkit.enable = true;
    services.gvfs.enable = true;
    services.upower.enable = true;

    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        (nerdfonts.override { 
         fonts = ["FiraCode"]; 
        })
        fira-sans
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        overpass
        liberation_ttf
        inter
      ];

      fontconfig = {
        defaultFonts = {
          serif = [ "Noto Serif" "Noto Serif CJK JP" ];
          sansSerif = [ "Fira Sans" "Noto Sans CJK JP" ];
          monospace = [ "FiraCode Nerd Font" "Noto Sans Mono CJK JP" ];
        };
      };
    };
  };
}
