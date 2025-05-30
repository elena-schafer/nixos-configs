{ config, lib, pkgs, ... }:

let
  cfg = config.desktop.recording;
in {
  imports = [
    ./hyprland
  ];
  options.desktop.recording = {
    enable = lib.mkEnableOption "Enable Recording Software";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      obs-studio.enable = true;
    };
  };
}

