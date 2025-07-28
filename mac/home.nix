{
  config,
  pkgs,
  ...
}: let
  username = "mvaldes";
  unstable = import <nixpkgs-unstable> {};
  homePath = "/Users/${username}";
in {
  home.username = "mvaldes";
  home.homeDirectory = "/Users/mvaldes";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Utilities
    unstable.neovim
    tldr
    htop
    jq
    tree
    fd
    ripgrep
    kubectl
    kubernetes-helm
    gh
    awscli2
    doppler
    ncdu
    stern
    glow
    dig
    alejandra
    aerospace
    flameshot
    pnpm
    devbox
    go-task
    k9s

    # languages
    nodejs_20
    jdk
    cargo
    lua

    # lsp
    marksman
    ltex-ls
  ];

  home.file = {
    ".ssh/config" = {
      source = "${homePath}/git/dotfiles/.ssh/config";
    };
    ".local/bin" = {
      source = "${homePath}/git/dotfiles/scripts";
      recursive = true;
    };
    ".aws/config" = {
      source = "${homePath}/git/dotfiles/.aws/config";
    };
    ".config/wezterm" = {
      source = "${homePath}/git/dotfiles/.config/wezterm";
    };
    ".config/ghostty" = {
      source = "${homePath}/git/dotfiles/.config/ghostty";
    };
    ".config/aerospace" = {
      source = "${homePath}/git/dotfiles/.config/aerospace";
    };
    ".config/direnv/direnv.toml" = {
      source = "${homePath}/git/dotfiles/.config/direnv/direnv.toml";
    };
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homePath}/git/dotfiles/.config/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$PATH:$HOME/.local/bin:$HOME/.vorpal/bin";
    LANG = "en_US.UTF-8";
  };

  programs.home-manager.enable = true;

  imports = [
    "${homePath}/git/dotfiles-nix/modules/git.nix"
    "${homePath}/git/dotfiles-nix/modules/zsh.nix"
    "${homePath}/git/dotfiles-nix/modules/shell.nix"
    "${homePath}/git/dotfiles-nix/modules/tmux.nix"
  ];
}
