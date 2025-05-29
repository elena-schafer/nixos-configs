
{ config, lib, pkgs, ... }:

let
  cfg = config.hardware.nvidia;
in {
  options.hardware.nvidia = {
    enable = lib.mkEnableOption "Enable nvidia drivers";
  };
  config = lib.mkIf cfg.enable {
    # NOTE: does not currently support different driver versions
    hardware.graphics = {
      enable = true;
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
