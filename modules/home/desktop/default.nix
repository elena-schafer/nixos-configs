inputs@{
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
    ./alacritty.nix
    ./firefox.nix
    ./hyprland
    ./streaming
    ./defaultApps.nix
    ./wifi
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Programs";
  };

  config = lib.mkIf cfg.enable {
    # TODO: these should go into a separate module that can be called on by rice modules (or just in the rice module?)
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          position = "bottom";
          height = 30;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/submap"
          ];
          modules-center = [ ];
          modules-right = [
            "tray"
            "pulseaudio"
            "network"
            "battery"
            #"battery#bat2"
            "clock"
          ];
          "hyprland/workspaces" = {
            "persistent-workspaces" = {
              "DP-1" = [
                1
                2
                3
                4
                5
              ];
              "DP-2" = [
                6
                7
                8
                9
                10
              ];
            };
          };
        };
      };
    };
    services.dunst = {
      enable = true;
    };

    services.easyeffects = {
      enable = true;
    };
    home.packages = with pkgs; [
      brave
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

      libreoffice
      hunspell # required for libreoffice spell check
      hunspellDicts.en_US

      bitwarden-desktop

      libnotify
    ];
  };
}
