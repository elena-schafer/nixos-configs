inputs@{ config, pkgs, lib, ... }:

{
  # If we want to use some software early, overlays or patching are good trick to use
  # https://wiki.nixos.org/wiki/Nixpkgs/Patching_Nixpkgs
	# https://nixos-and-flakes.thiscute.world/nixpkgs/overlays
	nixpkgs.overlays = [
 		(final: prev: {
			openjdk8 = prev.openjdk8.overrideAttrs {
       	separateDebugInfo = false;
       	__structuredAttrs = false;
      };
		})
	];
}
