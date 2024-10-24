# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{pkgs, ...}: let
  unstable = import <nixos-unstable> {};
  home-config = import ./home-wsl.nix;
in {
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.docker-desktop.enable = true;
  wsl.interop.includePath = true;
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

  system.stateVersion = "24.05"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = [unstable.neovim pkgs.git pkgs.wget pkgs.unzip pkgs.lua pkgs.gnumake pkgs.clang pkgs.nixd];
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  users.defaultUserShell = pkgs.zsh;
  time.timeZone = "America/Chicago";
  time.hardwareClockInLocalTime = true;
  nixpkgs.config.allowUnfree = true;

  home-manager.users.nixos = home-config;
}
