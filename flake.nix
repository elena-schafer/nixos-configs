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
    # If we want to use some software early, overlays or patching are good trick to use
    # https://wiki.nixos.org/wiki/Nixpkgs/Patching_Nixpkgs
    # nixpkgs.overlays = [ (import ./overlay.nix) ];

    # TODO: Would like to make it so hosts need not be defined here
    # Rather automatically read the host options from the hosts/ dir and put them here
    # https://ayats.org/blog/no-flake-utils
    nixosConfigurations = builtins.listToAttrs (builtins.map (
      host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          modules = [
            (./. + ("/hosts/" + host + "/configuration.nix")) # parenthesis are very exact
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
      }
    ) (builtins.attrNames (builtins.readDir ./hosts)));
  };
}

