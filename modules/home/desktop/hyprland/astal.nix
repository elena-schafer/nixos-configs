inputs@{ configs, lib, pkgs, ... }:

{
  # Packages that should be installed to the user profile.
  home.packages = 
		(with pkgs; [
			lua
		])
		++
		(with pkgs.astal; [
			apps
			astal3
			astal4
			auth
			battery
			bluetooth
			cava
			gjs
			greet
			hyprland
			io
			mpris
			network
			notifd
			powerprofiles
			river
			tray
			wireplumber
  	]);
}
