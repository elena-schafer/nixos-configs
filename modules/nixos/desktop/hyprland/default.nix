{ config, lib, pkgs, ... }:

let
  cfg = config.desktop.hyprland;
in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.systemPackages = with pkgs; [
		  hyprpaper
		];
  };
}

