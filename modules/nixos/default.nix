{ config, lib, pkgs, home-manager, ... }:

{
  imports = [
    ./core.nix
    ./desktop
    ./hardware
  ];
}

