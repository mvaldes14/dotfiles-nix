{ pkgs, ... }:
let
  myNvim = pkgs.vimUtils.buildVimPlugin {
    name = "mvaldes";
    src = ../config/nvim;
  };
in
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withRuby = true;
    withNodeJs = true;
    defaultEditor = true;
    plugins = with pkgs; [
      myNvim
    ];
    extraLuaConfig = ''
      require("mvaldes")
    '';
  };
}
