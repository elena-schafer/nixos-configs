{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.cask1 = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/cask1/configuration.nix ];
    };
    nixosConfigurations.annabellee2 = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/annabellee2/configuration.nix ];
    };
  };
}

