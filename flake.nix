{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
    ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, nix-colors, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.waddle-dee = nixpkgs.lib.nixosSystem {
        specialArgs = { 
          inherit inputs nix-colors; 
          rootPath = ./.;
        };
        modules = [ 
          ./hosts/waddle-dee/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      nixosConfigurations.waddle-doo = nixpkgs.lib.nixosSystem {
        specialArgs = { 
          inherit inputs nix-colors; 
          rootPath = ./.;
        };
        modules = [ 
          ./hosts/waddle-doo/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      devShells.system."dotnet" = let
        dotnet = pkgs.dotnetCorePackages.dotnet_9.sdk;
      in
      pkgs.mkShell {
        packages = [ dotnet jetbrains.rider android-studio ];
        sessionVariables = {
          DOTNET_PATH = "${dotnet}/bin/dotnet";
          DOTNET_ROOT = "${dotnet}/share/dotnet";
        };
      };
    };
}
