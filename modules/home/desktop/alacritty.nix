{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      env.TERM = "xterm-256color";
      window = {
        startup_mode = "Maximized";
	opacity = 0.8;
      };
      font = {
        normal = {
	  family = "Hack Nerd Font Mono";
	  style = "Regular";
	};
        bold = {
	  family = "Hack Nerd Font Mono";
	  style = "Bold";
	};
        italic = {
	  family = "Hack Nerd Font Mono";
	  style = "Italic";
	};
        bold_italic = {
	  family = "Hack Nerd Font Mono";
	  style = "Bold Italic";
	};
	size = 10;
      };
    };
  };
}
