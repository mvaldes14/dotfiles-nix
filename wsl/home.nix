{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.username = "mvaldes";
  home.homeDirectory = "/home/mvaldes";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  home.sessionVariables = {
    EDITOR = "nvim";
    LC_ALL = "C.UTF-8";
    PATH = "$PATH:$HOME/.local/bin";
  };

  home.packages = with pkgs; [
    screenkey
    wsl-open
    httpie
    jdk
    marksman
    ltex-ls
  ];

  imports = [
    ../modules/common.nix
  ];
}
