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
      set -ag terminal-overrides ",$TERM:RGB"
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"
    '';
    # extraConfigBeforePlugins = ;

    # Settings based on tmux-sensible
    escapeTime = 0;
    historyLimit = 50000;
    aggressiveResize = true;
    terminal = "tmux-256color";

  };
}

