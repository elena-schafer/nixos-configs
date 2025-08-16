{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.desktop.hyprland;
  background = ./background.png;
in
{
  # imports = [
  # ];
  # desktop.hyprland.enable option declared in nixos/desktop/hyprland/default.nix
  options.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland";
    monitors = lib.mkOption {
      default = [
        {
          name = "DP-0";
          index = 1;
          width = 1920;
          height = 1080;
          position-x = 0;
          position-y = 0;
        }
      ];
    };
  };
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = null;
      # TODO: pull from default applications to get applications for keybinds
      # TODO: change workspace keybinds based on monitor count (only setups for 1-2 monitors for now I guess)
      # TODO: fix cursor
      settings = {
        monitor = (
          builtins.map (
            monitor:
            "$mon${toString monitor.index},${toString monitor.width}x${toString monitor.height},${toString monitor.position-x}x${toString monitor.position-y},1"
          ) cfg.monitors
        );
      }
      // builtins.listToAttrs (
        builtins.map (monitor: {
          name = "$mon${toString monitor.index}";
          value = monitor.name;
        }) cfg.monitors
      );
      extraConfig = builtins.readFile ./hyprland.conf;
    };
    # TODO: Add option to control wallpaper
    # TODO: Add options for different wallpapers on different screens
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = "${background}";
        wallpaper = map (monitor: "${monitor.name}," + background) cfg.monitors;
        splash = false;
      };
    };
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
        };
        background = {
          # monitor = "";
          path = "${background}";
        };
        shape = {
          #monitor = "";
          size = "854, 1440";
          color = "rgba(0,0,0,0.2)";
          position = "0, 0";
          halign = "left";
          valign = "none";
        };
        label = {
          #monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M %P\")\"";
          color = "rgba(30,30,46,0.8)";
          font_size = 60;

          position = "-850, 10";
          halign = "center";
          valign = "center";
        };
        input-field = {
          #monitor = "";
          size = "300, 50";
          outline_thickness = "1";
          rounding = "18";
          outer_color = "rgba(255, 255, 255, 0.2)";
          inner_color = "rgba(255, 255, 255, 0.2)";
          font_color = "rgba(30, 30, 46, 0.8)";
          check_color = "rgba(255, 255, 255, 0.2)";
          fail_color = "rgba(255, 255, 255, 0.2)";

          fail_timeout = "1000";
          fail_transition = "0";
          fail_text = "";

          placeholder_text = "<i>Password</i>";
          fade_on_empty = false;

          position = "-850, -50";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
