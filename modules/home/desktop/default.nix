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
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Programs";
  };

  config = lib.mkIf cfg.enable {
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
    ];
  };
}
