{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    plugins = with pkgs.tmuxPlugins; [
      yank
      catppuccin
    ];
    extraConfig = ''
      set -g @catppuccin_flavor 'mocha'
      set -g status-keys emacs
      set -g focus-events on
      set -ag terminal-overrides ",$TERM:RGB"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind '%' split-window -h -c "#{pane_current_path}"
    '';
    aggressiveResize = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    mouse = true;
    terminal = "tmux-256color";
  };
}
