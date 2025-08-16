{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.desktop;
in
{
  imports = [
    ./hyprland
    ./gaming.nix
  ];
  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Installation";
  };
  config = lib.mkIf cfg.enable {

    services.greetd.enable = true;
    programs.regreet.enable = true;

    programs.dconf.enable = true; # needed for easyeffects to work
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
