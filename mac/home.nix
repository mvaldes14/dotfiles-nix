{
  config,
  pkgs,
  ...
}: let
  username = "mvaldes";
  homePath = "/Users/${username}";
in {
  nixpkgs.config.allowUnfree = true;
  home.username = "mvaldes";
  home.homeDirectory = "/Users/mvaldes";

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
    glow
    dig
    alejandra
    aerospace
    pnpm
    devbox
    go-task
    k9s
    claude-code
    opencode

    # languages
    nodejs_22
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
    ".config/ghostty" = {
      source = "${homePath}/git/dotfiles/.config/ghostty";
    };
    ".config/aerospace" = {
      source = "${homePath}/git/dotfiles/.config/aerospace";
    };
    ".config/direnv/direnv.toml" = {
      source = "${homePath}/git/dotfiles/.config/direnv/direnv.toml";
    };
    ".config/opencode/opencode.json" = {
      source = "${homePath}/git/dotfiles/.config/opencode/opencode.json";
    };
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${homePath}/git/dotfiles/.config/nvim";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PATH = "$HOME/.local/bin:$HOME/.vorpal/bin:$HOME/.opencode/bin:$PATH";
    LANG = "en_US.UTF-8";
  };

  programs.home-manager.enable = true;

  imports = [
    ../modules/git.nix
    ../modules/zsh.nix
    ../modules/shell.nix
    ../modules/tmux.nix
  ];
}
