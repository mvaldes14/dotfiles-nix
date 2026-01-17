{pkgs, ...}: let
  isMac = pkgs.stdenv.isDarwin;
  homeDir =
    if isMac
    then "/Users/mvaldes"
    else "/home/mvaldes";
  copyCommand =
    if isMac
    then "pbcopy"
    else "xclip -sel clipboard";
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      yank
      vim-tmux-navigator
      copycat
      continuum
      fingers
      tmux-fzf
      tokyo-night-tmux
    ];
    extraConfig = ''
      ###############################
      #  Options
      ###############################
      # Ensure new panes/windows run zsh as interactive shell (sources .zshrc)
      set -g default-command "${pkgs.zsh}/bin/zsh -i"

      # Otherwise nvim colours are messed up
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ',xterm-256color:RGB'

      # set first window to index 1 (not 0) to map more to the keyboard layout
      set -g base-index 1
      set -g pane-base-index 0

      # pass through xterm keys
      set -g xterm-keys on

      # Automatically set window title
      set status on
      set -sg escape-time 0
      set -g set-titles on
      set -sg repeat-time 600

      # slightly longer pane indicators display time
      set -g display-panes-time 800

      # slightly longer status messages display time
      set -g display-time 1000

      # renumber windows when a window is closed
      set -g renumber-windows on

      # bar position
      set -g status-position top

      # Using backtick as prefix for better ergonomics
      unbind C-b
      set -g prefix C-space
      bind C-space send-prefix

      # Switch panes with Vi keys
      set-window-option -g mode-keys vi
      set -g status-keys vi
      set -g mode-keys vi
      # switch quicker
      bind l switch-client -l
      bind Tab last-window

      # Visual Activity and History
      setw -g monitor-activity on
      setw -g history-limit 5000
      set -g visual-activity on
      set -g visual-bell off
      set -g visual-silence on

      # Using the mouse to switch panes
      set -g mouse on
      bind -n MouseDrag1Pane select-pane -t =

      # Set clipboard
      set -g set-clipboard external
      set -g copy-command '${copyCommand}'

      # rename windows
      set-option -g status-interval 5
      set-option -g automatic-rename on
      set-option -g automatic-rename-format '#{b:pane_current_path}'

      ###############################
      # Keybinds
      ###############################
      # reload tmux config
      unbind r
      bind r \
          source-file ${homeDir}/.config/tmux/tmux.conf \;\
              display-message 'Reloaded tmux config.'

      # Vertical splits with g or C-g
      unbind g
      unbind C-g
      bind-key v split-window -h -c '#{pane_current_path}'
      bind-key C-v split-window -h -c '#{pane_current_path}'

      # Horizontal splits with v or C-h
      unbind h
      unbind C-h
      bind-key h split-window -v -c '#{pane_current_path}'
      bind-key C-h split-window -v -c '#{pane_current_path}'

      # Ctrl - w or w to kill panes
      unbind w
      unbind C-w
      bind-key w kill-pane
      bind-key C-w kill-pane

      # Ctrl - t or t new window
      unbind t
      unbind C-t
      bind-key t new-window -c '#{pane_current_path}'
      bind-key C-t new-window -c '#{pane_current_path}'

      #Resizing penes with alt
      bind -n C-M-h resize-pane -L 10
      bind -n C-M-l resize-pane -R 10
      bind -n C-M-k resize-pane -U 10
      bind -n C-M-j resize-pane -D 10

      # Ctrl + a + n : New session
      unbind n
      unbind C-n
      bind-key n new-session
      bind-key C-n new-session
      # synchronize all panes in a window
      unbind C-S
      bind C-y set-window-option synchronize-panes

      # Copy from tmux to system clipboard
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "${copyCommand}"
      bind C-v paste-buffer

      #####################################
      # Custom
      #####################################
      bind-key -r f run-shell "tmux neww ${homeDir}/.local/bin/tmux-sessionizer.sh"
      bind-key C-d detach-client
      bind-key Q display-popup -w '80%' -h '80%' -T opencode -S 'fg=blue,bg=default' opencode

      #####################################
      # Plugin Options
      #####################################

      # tokyo-night-tmux
      set -g @tokyo-night-tmux_theme storm
      set -g @tokyo-night-tmux_transparent 1
      set -g @tokyo-night-tmux_show_path 1
      set -g @tokyo-night-tmux_show_wbg 1

      # tmux-yank
      set -g @yank_selection 'clipboard'

      # vim-tmux-navigator
      bind C-l send-keys 'C-l'

      # tmux-fingers
      set -g @fingers-key S
      set -g @fingers-keyboard-layout "qwerty-homerow"

      # tmux-continuum / tmux-resurrect
      set -g @continuum-restore 'on'
      set -g @resurrect-dir '${homeDir}/.tmux/resurrect-dir'
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-save-interval '10'

      # tmux-fzf
      unbind s
      bind s run-shell "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
      bind C-s run-shell "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
    '';
  };
}
