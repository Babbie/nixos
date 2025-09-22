{
  description = "Bab's NixOS Config";
  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, home-manager, ...}: {
    nixosConfigurations.waddle-dee = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
	{
          home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.bab = import ./home.nix;
	    backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };
	  };
	}
      ];
    };
  };
}
