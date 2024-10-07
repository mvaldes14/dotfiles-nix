{ pkgs, ... }:
{

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --no-ignore --hiden --follow --glob '!.git/*'";
    defaultOptions = [ "--height 50%" "--ansi" ];
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    initExtra = ''
      source $HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
      source $HOME/git/dotfiles/.config/zsh/zsh_functions
      export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
    '';
    shellAliases = {
      cat = "bat";
      lg = "lazygit";
      kls = "kitchen list";
      krm = "kitchen destroy";
      kmk = "kitchen converge";
      be = "bundle exec";
      s = "doppler run";
      tf = "terraform";
      k = "kubectl";
      du = "ncdu";
      cdg = "~/.local/bin/tmux-layout.sh";
      cdr = "cd $(find ~/git -maxdepth 3 -type d | fzf --no-preview)";
      tmks = "~/.local/bin/tmux-sessionkiller.sh";
      tmkw = "~/.local/bin/tmux-windowkiller.sh";
      dot = "cd $DOTFILES";
      v = "nvim";
      vwiki = "pushd /mnt/c/Users/migue/Documents/wiki && nvim";
      kk = "k9s";
      ollama = "ollama.exe";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "aws" "vi-mode" "kubectl" "fzf" ];
    };
    sessionVariables = {
      TERM = "screen-256color";
      EDITOR = "nvim";
      XDG_CONFIG_HOME = "$HOME/.config";
      LC_ALL = "C.UTF-8";
      DOTFILES = "$HOME/git/dotfiles/";
    };
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
          sha256 = "gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
    ];
  };

}
