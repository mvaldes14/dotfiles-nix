{pkgs, ...}: let
  isMac = pkgs.stdenv.isDarwin;
  homeDir =
    if isMac
    then "/Users/mvaldes"
    else "/home/mvaldes";
in {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      yank
      vim-tmux-navigator
      copycat
      continuum
      tmux-sessionx
      tmux-sessionx
      fingers
    ];
    extraConfig = ''
      ${builtins.readFile "${homeDir}/git/dotfiles/.config/tmux/tmux.conf"}
      ${builtins.readFile "${homeDir}/git/dotfiles/.config/tmux/tmuxtheme.conf"}
    '';
  };
}
