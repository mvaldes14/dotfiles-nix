# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{pkgs, ...}: let
  home-config = import ./home.nix;
  username = "mvaldes";
in {
  imports = [
    # NixOS-WSL modules are now imported via flake
  ];

  wsl.enable = true;
  wsl.defaultUser = username;
  wsl.docker-desktop.enable = true;
  wsl.interop.includePath = true;

  # Define a user account with explicit UID to match the current system
  users.users.${username} = {
    uid = 1001;
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = ["wheel"];
  };
  wsl.extraBin = with pkgs; [
    # Binaries for Docker Desktop wsl-distro-proxy
    {src = "${coreutils}/bin/mkdir";}
    {src = "${coreutils}/bin/cat";}
    {src = "${coreutils}/bin/whoami";}
    {src = "${coreutils}/bin/ls";}
    {src = "${busybox}/bin/addgroup";}
    {src = "${su}/bin/groupadd";}
    {src = "${su}/bin/usermod";}
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  system.stateVersion = "25.05"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    neovim
    opencode
    git
    wget
    unzip
    lua
    gnumake
    clang
    nixd
    alejandra
    openai-whisper
    luarocks
    gcc
    go-task
    bitwarden-cli
    devbox
  ];
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.ssh.startAgent = true;
  users.defaultUserShell = pkgs.zsh;
  time.timeZone = "America/Chicago";
  time.hardwareClockInLocalTime = true;
  nixpkgs.config.allowUnfree = true;
  home-manager.users."${username}" = home-config;
}
