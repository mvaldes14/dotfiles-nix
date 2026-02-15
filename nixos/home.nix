{
  pkgs,
  config,
  ...
}: let
  username = "mvaldes";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  home.enableNixpkgsReleaseCheck = false;

  home.sessionVariables = {
    EDITOR = "nvim";
    LC_ALL = "C.UTF-8";
    PATH = "$PATH:$HOME/.local/bin";
  };

  home.file = {
    ".config/wezterm" = {
      source = /home/${username}/git/dotfiles/.config/wezterm;
      target = "/home/${username}/.config/wezterm";
    };
    ".config/waybar" = {
      source = /home/${username}/git/dotfiles-nix/config/waybar;
    };
    ".config/ghostty/config".source = /home/${username}/git/dotfiles/.config/ghostty/config;
  };

  #Pkgs installed via os
  # steam, spotify, discord, i3, rofi, lutris, obs, obsidian
  home.packages = with pkgs; [
    sox
    screenkey
    nixpkgs-fmt
    docker-compose
    feh
    bat
    bitwarden-cli
    brightnessctl
    playerctl
    tokyonight-gtk-theme
    hyprshot
    nerdfetch
    go-task
    nodejs_20
    jdk
    marksman
    ltex-ls
  ];

  imports = [
    ../modules/common.nix
  ];
}
