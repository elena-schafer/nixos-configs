{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.cask1 = nixpkgs.lib.nixosSystem {
      modules = [ 
        ./hosts/cask1/configuration.nix
      ];
    };
    nixosConfigurations.annabellee2 = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/annabellee2/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.elena = import hosts/annabellee2/home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };
  };
}

