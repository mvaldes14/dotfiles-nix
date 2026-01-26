{
  config,
  pkgs,
  ...
}: let
  username = "mvaldes";
  homePath = "/Users/${username}";
  dotfilesPath = "${homePath}/git/dotfiles";
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${path}";
in {
  home.username = username;
  home.homeDirectory = homePath;

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # Utilities
    neovim
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
    dig
    alejandra
    pnpm
    devbox
    go-task
    k9s
    claude-code
    opencode

    # languages
    nodejs_22
    cargo
    lua

  ];

  home.file = {
    ".ssh/config".source = mkSymlink ".ssh/config";
    ".local/bin".source = mkSymlink "scripts";
    ".aws/config".source = mkSymlink ".aws/config";
    ".config/ghostty".source = mkSymlink ".config/ghostty";
    ".config/aerospace".source = mkSymlink ".config/aerospace";
    ".config/direnv/direnv.toml".source = mkSymlink ".config/direnv/direnv.toml";
    ".config/opencode/opencode.json".source = mkSymlink ".config/opencode/opencode.json";
    ".config/nvim".source = mkSymlink ".config/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.vorpal/bin"
    "$HOME/.opencode/bin"
  ];

  programs.home-manager.enable = true;

  imports = [
    ../modules/git.nix
    ../modules/zsh.nix
    ../modules/shell.nix
    ../modules/tmux.nix
  ];
}
