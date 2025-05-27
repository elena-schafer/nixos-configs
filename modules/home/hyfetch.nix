{ config, lib, pkgs, ... }:

{
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      light_dark = "dark";
      color_align = {
        mode = "horizontal";
	custom_colors = [];
	fore_back = builtins.null;
      };
      backend = "neofetch";
      args = builtins.null;
      distro = builtins.null;
      pride_month_shown = [];
      pride_month_disable = false;
    };
  };
}
