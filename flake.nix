{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, nur, home-manager, ... }: {
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
	  home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}

