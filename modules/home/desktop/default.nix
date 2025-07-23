inputs@{ configs, pkgs, ... }:

let
	cfg = config.desktop;
in {
  imports = [
    ./alacritty.nix
    ./firefox.nix
		./hyprland
		./streaming
  ];

	options.desktop = {
		enable = lib.mkEnableOption "Enable Desktop Programs"
	}

	config = lib.mkIf cfg.enable {
		programs.noisetorch.enable = true;
		home.packages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
				withVencord = true;
      })
			krita
			nerd-fonts.hack
			pavucontrol
			rofi-wayland
			vlc
			xfce.thunar
			zoom-us
		];
	}
}
