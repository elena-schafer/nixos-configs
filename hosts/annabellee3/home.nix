inputs@{
  configs,
  pkgs,
  home-manager,
  ...
}:

{
  imports = [ ../../modules/home ];

  desktop.hyprland.enable = true;
  desktop.hyprland.monitors = [
    {
      name = "eDP-1";
      index = 1;
      width = 1920;
      height = 1080;
      position-x = 0;
      position-y = 0;
    }
  ];
  desktop.enable = true;
}
