{
  description = "Bab's NixOS Config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    bizhawk = {
      url = "github:TASEmulators/BizHawk";
      flake = false;
    };

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      waddle-dee = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/waddle-dee/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.default
        ];
        specialArgs = { inherit inputs; };
      };
      waddle-doo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hosts/waddle-doo/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.home-manager.nixosModules.default
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
