{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      search = {
        default = "ddg";
	force = true;
	order = [ "ddg" "wikipedia" "Nix Packages" "NixOS Wiki" ];
	engines = {
	  "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            icon = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };
	  
	  "ddg".metaData.hidden = false;
	  "wikipedia".metaData.hidden = false;
	  "google".metaData.hidden = true;
	  "amazondotcom-us".metaData.hidden = true;
	  "bing".metaData.hidden = true;
	  "ebay".metaData.hidden = true;
	};
      };
    };
  };
}
