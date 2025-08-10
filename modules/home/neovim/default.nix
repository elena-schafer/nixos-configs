{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:

# TODO: options for adding and removing functions such as notes and colorscheme, accomplish by breaking into modules?
let
  # Very specific function for the purposes of this file.
  # basically lib.filesystem.listFilesRecursive but avoiding putting anything in the nix store.
  listFilesRecursiveStrings =
    dirString:
    lib.flatten (
      lib.mapAttrsToList (
        name: type:
        if type == "directory" then
          listFilesRecursiveStrings (dirString + "/${name}")
        else
          dirString + "/${name}"
      ) (builtins.readDir (./. + dirString))
    );
  # creates attr set of files for home-manager to insert into home from a directory.
  nvimDirToHomeFiles =
    dirString:
    builtins.listToAttrs (
      map (file: {
        name =
          "nvim" + (builtins.substring (builtins.stringLength dirString) (builtins.stringLength file) file);
        value = {
          text = lib.readFile (./. + ("/" + file));
        };
      }) (listFilesRecursiveStrings dirString)
    );
in
{
  xdg.configFile = {
    "nvim/init.lua" = {
      text = ''
        				require('options')
        				require('lz.n').load('plugins')
        				require('aliases')
        				require('custom-keys')
        			'';
    };
  } // nvimDirToHomeFiles "/config";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      lz-n
      catppuccin-nvim
      oil-nvim
      transparent-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      nvim-lspconfig
      nvim-treesitter
      harpoon2
    ];
  };

  home.packages = with pkgs; [
    lua-language-server
    nixd
    nixfmt-rfc-style
  ];
}
