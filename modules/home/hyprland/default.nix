{ config, lib, pkgs, ... }:

let
  cfg = config.desktop.hyprland;
in {
  # imports = [
  # ];
  # desktop.hyprland.enable option declared in nixos/desktop/hyprland/default.nix
  options.desktop.hyprland = {
    monitors = lib.mkOption {
      default = [
        { 
	  name = "DP-0";
	  width = 1920;
	  height = 1080;
	  position-x = 0;
	  position-y = 0;
	}
      ];
    }
  };
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
	monitor = (builtins.map 
	  (monitor: "${monitor.name},${monitor.width}x${monitor.height},${monitor.position-x}x${monitor.position-y},1")
	  cfg.monitors
	)
      };
      extraConfig = (builtins.readFile ./hyprland.conf);
    };
  };
}

