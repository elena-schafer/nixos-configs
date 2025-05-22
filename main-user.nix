{ config, lib, pkgs, ... }:

{
  config = {
    users.users.elena = {
      isNormalUser = true;
      initialPassword = "secret";
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };
  }
}

