inputs@{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.file."scripts/bin/wifi-menu" = {
    source = ./wifi-menu;
    executable = true;
  };
}
