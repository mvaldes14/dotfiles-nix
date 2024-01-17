{ pkgs, ...} :
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.mode-indicator
      tmuxPlugins.resurrect
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.copycat
      tmuxPlugins.continuum
    ];
    extraConfig = builtins.readFile ../config/tmux/tmux.conf;
  };

} 
