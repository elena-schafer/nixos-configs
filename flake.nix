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
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    # If we want to use some software early, overlays or patching are good trick to use
    # https://wiki.nixos.org/wiki/Nixpkgs/Patching_Nixpkgs
    # nixpkgs.overlays = [ (import ./overlay.nix) ];

    nixosConfigurations = builtins.listToAttrs (builtins.map (
      host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/${host}/configuration.nix
	    			home-manager.nixosModules.home-manager
						{
						  home-manager.useGlobalPkgs = true;
						  home-manager.useUserPackages = true;
							home-manager.backupFileExtension = "home-backup";
  						home-manager.extraSpecialArgs = { inherit inputs; };
						  home-manager.users.elena = ./hosts/${host}/home.nix;
						}
          ];
				};
      }
    ) (builtins.attrNames (builtins.readDir ./hosts)));
  };
}
