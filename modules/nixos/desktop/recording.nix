{ config, lib, pkgs, ... }:

let
  cfg = config.recording;
in {
  imports = [
    ./hyprland
  ];
  options.recording = {
    enable = lib.mkEnableOption "Enable Recording Software";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      obs-studio.enable = true;
    };
  };
}

