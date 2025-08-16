{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:

# TODO: options for adding and removing functions such as notes and colorscheme, accomplish by breaking into modules?
# units to separate into
# - core
# - ide
# - notes
# - latex (because texliveFull is a large package)
# - java (if install is large enough)
# - potentially other language server installs
let
  # Very specific function for the purposes of this file.
  # basically lib.filesystem.listFilesRecursive but avoiding putting anything in the nix store.
  # TODO: rework to use xdg.configFile.<name>.source
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
  makeOptional = plugin: {
    plugin = plugin;
    optional = true;
  };
  makeListOptional = pluginList: map makeOptional pluginList;
in
{
  xdg.configFile = {
    "nvim/init.lua" = {
      text = ''
        							require('lz.n').load('plugins')
        							require('options')
        							require('aliases')
        							require('custom-keys')
               						'';
    };
  }
  // nvimDirToHomeFiles "/config";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      pkgs.vimPlugins.lz-n
    ]
    ++ makeListOptional (
      with pkgs.vimPlugins;
      [
        catppuccin-nvim
        oil-nvim
        transparent-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        plenary-nvim
        nvim-lspconfig
        (nvim-treesitter.withPlugins (p: [
          p.c
          p.python
          p.lua
          p.nix
        ]))
        nvim-treesitter-textobjects
        harpoon2
        gitsigns-nvim
        nvim-autopairs
        lualine-nvim
        todo-comments-nvim
        zk-nvim
        render-markdown-nvim
        markdown-nvim
        vimtex
      ]
    );
  };

  home.packages = with pkgs; [
    lua-language-server
    nixd
    nixfmt-rfc-style
    zathura
    texliveFull
  ];
  # home.file.".local/share/applications/zknote.desktop".text = ''
  #   		[Desktop Entry]
  #   		Type=Application
  #   		Name=zkNote
  #   		Exec=zknote-helper %u
  #   		MimeType=x-scheme-handler/zknote;
  #   		NoDisplay=false
  #   		Terminal=false
  #   	'';

  # PDF to md link support for note setup
  xdg.desktopEntries."zknote" = {
    name = "zkNote";
    exec = "zknote-helper %u";
    mimeType = [ "x-scheme-handler/zknote" ];
    terminal = false;
    noDisplay = false;
  };
  # TODO: refactor to use $ZK_NOTEBOOK_DIR
  home.file."scripts/bin/zknote-helper" = {
    text = ''
      		#!/usr/bin/env bash
      		FileName=$(echo $1 | awk -F '//|\\.' '{print $2}')
      		FileType=$(echo $1 | awk -F '//|\\.' '{print $3}')

      		if [ "$FileType" = "md" ]; then
      			nvim --remote-send "<C-\><C-N>:n /home/elena/notes/$FileName.md<CR>" --server ~/.local/share/nvim/zktex	
      		elif [ "$FileType" = "tex" ]; then
      			nvim --remote-send "<C-\><C-N>:n /home/elena/notes/latex/$FileName.tex<CR>" --server ~/.local/share/nvim/zktex	
      		fi
      	'';
    executable = true;
  };
  home.sessionPath = [
    "$HOME/scripts/bin"
  ];
  home.sessionVariables = {
    ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/notes";
  };
}
