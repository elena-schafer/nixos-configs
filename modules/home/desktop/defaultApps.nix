inputs@{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "firefox.desktop" ];
    "text/html" = [ "firefox.desktop" ];
  };
}
