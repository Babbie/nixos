{
  description = "Bab's NixOS Config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.waddle-dee = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./hosts/waddle-dee/configuration.nix
	inputs.home-manager.nixosModules.default
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
