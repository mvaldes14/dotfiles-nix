{ pkgs, ... }:
let
  tmux-sessionx = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "sessionx";
    version = "unstable-2023-01-06";
    src =
      pkgs.fetchFromGitHub
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
    plugins = with pkgs.tmuxPlugins; [
      sensible
      mode-indicator
      resurrect
      yank
      vim-tmux-navigator
      copycat
      continuum
      tmux-sessionx
    ];
    extraConfig = ''
      run-shell ${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode_indicator.tmux
      ${builtins.readFile /home/mvaldes/git/dotfiles/.config/tmux/tmux.conf}
    '';
  };
}
