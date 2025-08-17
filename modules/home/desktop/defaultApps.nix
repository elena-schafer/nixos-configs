inputs@{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.mineApps.defaultApplications = {
    "application/pdf" = [ "firefox.desktop" ];
    "text/html" = [ "firefox.desktop" ];
  };
}
