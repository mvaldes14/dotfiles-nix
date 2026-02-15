{
  config,
  pkgs,
  ...
}: let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/git/dotfiles/${path}";
in {
  home.username = "mvaldes";
  home.homeDirectory = "/Users/mvaldes";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    pnpm
    alejandra
  ];

  home.file = {
    ".config/ghostty".source = mkSymlink ".config/ghostty";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.vorpal/bin"
  ];

  imports = [
    ../modules/common.nix
  ];
}
