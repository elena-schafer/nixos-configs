{ config, lib, pkgs, ... }:

let
  cfg = config.desktop.gaming;
in {
  options.desktop.gaming = {
    enable = lib.mkEnableOption "Enable Desktop Installation";
  };
  config = lib.mkIf cfg.enable {
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };
}

