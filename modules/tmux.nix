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
  tokyo-night = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tokyo-night";
    version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "janoamaral";
      repo = "tokyo-night-tmux";
      rev = "master";
      sha256 = "sha256-3rMYYzzSS2jaAMLjcQoKreE0oo4VWF9dZgDtABCUOtY=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      # tmuxPlugins.mode-indicator
      resurrect
      yank
      vim-tmux-navigator
      copycat
      continuum
      tmux-sessionx
    ];
    # run-shell ${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode_indicator.tmux
    extraConfig = ''
      run-shell /nix/store/vc02gww5zqszldw0rmq1jh1iz4w4js1l-tmuxplugin-tokyo-night-unstable-2023-01-06/share/tmux-plugins/tokyo-night/tokyo-night.tmux
      ${builtins.readFile ../config/tmux/tmux.conf}
    '';
  };
}
