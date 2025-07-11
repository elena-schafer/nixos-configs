
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, home-manager, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true; # necessary to boot in virtual box
    devices = [ "nodev" ];
  };

  networking.networkmanager.enable = true;
	services.udisks2.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elena = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # packages = with pkgs; [
    # ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim # TODO: switch to just vim? neovim installed through home-manager?
    wget
    curl
    git
    btop
    stow
		fzf
		restic
		zk
  ];
}

