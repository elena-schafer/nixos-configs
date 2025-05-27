{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    plugins = [
      pkgs.tmuxPlugins.yank
      pkgs.tmuxPlugins.catppuccin
    ];
    extraConfig = ''
      set -g display-time 4000
      set -g status-interval 5
      set -g status-keys emacs
      set -g focus-events on
      set -g mouse on
    '';
    # extraConfigBeforePlugins = ;

    # Settings based on tmux-sensible
    escapeTime = 0;
    historyLimit = 50000;
    aggressiveResize = true;
    terminal = "screen-256color";

  };
}

