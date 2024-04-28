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
in
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
      tmux-sessionx
    ];
    extraConfig = ''
      ${builtins.readFile ../config/tmux/tmux.conf}
      run-shell ${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode_indicator.tmux
    '';
  };
}
