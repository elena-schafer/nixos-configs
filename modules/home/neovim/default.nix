{ config, lib, pkgs, home-manager, ... }:

# TODO: options for adding and removing functions such as notes and colorscheme, accomplish by breaking into modules.
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
		"nvim/lua/options.lua" = { text = lib.readFile ./config/lua/options.lua; };
		"nvim/lua/aliases.lua" = { text = lib.readFile ./config/lua/aliases.lua; };
		"nvim/lua/custom-keys.lua" = { text = lib.readFile ./config/lua/custom-keys.lua; };
		"nvim/lua/plugins/init.lua" = { text = lib.readFile ./config/lua/plugins/init.lua; };
		"nvim/lua/plugins/colorscheme.lua" = { text = lib.readFile ./config/lua/plugins/color-scheme.lua; };
		"nvim/lua/plugins/oil.lua" = { text = lib.readFile ./config/lua/plugins/oil.lua; };
	};
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		plugins = with pkgs.vimPlugins; [
			lz-n
			catppuccin-nvim
			oil-nvim
			transparent-nvim
		];
	};
}
