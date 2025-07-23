{ config, lib, pkgs, ... }:

let
  cfg = config.desktop;
in {
  imports = [
    ./hyprland
    ./gaming.nix
  ];
  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Installation";
  };
  config = lib.mkIf cfg.enable {
    # TODO: ensure only one desktop environment is enabled 
    # probably use assert
    # or this https://nixos.org/manual/nixos/stable/index.html#sec-assertions-warnings

    services = {
      printing.enable = true;
      pipewire = {
        enable = true;
        pulse.enable = true;
      };
      libinput.enable = true;
    };
    # environment.systemPackages = with pkgs; [
    # ];
  };
}

