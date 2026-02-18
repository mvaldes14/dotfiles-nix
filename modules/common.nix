{
  config,
  pkgs,
  ...
}: let
  dotfilesPath = "${config.home.homeDirectory}/git/dotfiles";
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${path}";
in {
  programs.home-manager.enable = true;

  home.file = {
    ".ssh/config".source = mkSymlink ".ssh/config";
    ".local/bin".source = mkSymlink "scripts";
    ".aws/config".source = mkSymlink ".aws/config";
    ".config/nvim".source = mkSymlink ".config/nvim";
    ".config/direnv/direnv.toml".source = mkSymlink ".config/direnv/direnv.toml";
    ".config/opencode/opencode.json".source = mkSymlink ".config/opencode/opencode.json";
    ".claude/settings.json".source = mkSymlink "claude/settings.json";
    ".claude/skills".source = mkSymlink "claude/skills";
    ".claude/commands".source = mkSymlink "claude/commands";
    ".claude/agents".source = mkSymlink "claude/agents";
  };

  home.packages = with pkgs; [
    bash
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
    neovim
    lua
    cargo
    claude-code
    opencode
    nodejs_22
    devbox
    go-task
  ];

  imports = [
    ./git.nix
    ./zsh.nix
    ./shell.nix
    ./tmux.nix
  ];
}
