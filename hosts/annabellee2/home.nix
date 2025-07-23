inputs@{ configs, pkgs, home-manager, ... }:

{
  imports = [ ../../modules/home ];

	desktop.hyprland.monitors = [
		{
			name = "DP-0";
			index = 1;
			width = 2560;
			height = 1440;
			position-x = 0;
			position-y = 0;
		}
		{
			name = "DP-1";
			index = 2;
			width = 2560;
			height = 1440;
			position-x = 2560;
			position-y = 0;
		}
	];
	desktop.enable = true;
	desktop.streaming.enable = true;
}
