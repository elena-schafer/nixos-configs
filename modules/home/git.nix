
{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "elena";
    userEmail = "elenaschafer12@gmail.com";
  };
}
