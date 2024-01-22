{ pkgs, ... }:
{
  programs.neovim = {
    enable = false;
    withPython3 = true;
    withRuby = true;
    withNodeJs = true;
    defaultEditor = true;
    plugins = with pkgs; [
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.lazy-nvim
    ];
  };
}
