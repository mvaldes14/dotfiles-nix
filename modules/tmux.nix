{ pkgs, ... }:
let
  tmux-sessionx = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "sessionx";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub
      {
        owner = "omerxx";
        repo = "tmux-sessionx";
        rev = "ac9b0ec219c2e36ce6beb3f900ef852ba8888095";
        sha256 = "sha256-TO5OG7lqcN2sKRtdF7DgFeZ2wx9O1FVh1MSp+6EoYxc=";
      };
  };
  tmux-tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night-tmux";
    version = "unstable-2021-05-14";
    src = pkgs.fetchFromGitHub
      {
        owner = "janoamaral";
        repo = "tokyo-night-tmux";
        rev = "b45b742eb3fdc01983c21b1763594b549124d065";
        sha256 = "sha256-k4CbfWdyk7m/T97ytxLOEMUKrkU5iJSIu3lvyT1B1jU=";
      };
  };
in
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      # tmuxPlugins.mode-indicator
      tmuxPlugins.resurrect
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.copycat
      tmuxPlugins.continuum
      tmux-sessionx
      tmuxPlugins.catppuccin
      tmux-tokyo-night
    ];
    # run-shell ${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode_indicator.tmux
    extraConfig = ''
      ${builtins.readFile ../config/tmux/tmux.conf}
    '';
  };
}
