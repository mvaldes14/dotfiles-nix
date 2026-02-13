{
  pkgs,
  lib,
  ...
}: {
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.k9s = {
    enable = true;
    skins.skin = "nord";
  };

  programs.lazygit = {
    enable = true;
    settings = {
      os.editorPreset = "nvim";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin";
    };
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catpuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-mocha.tmTheme";
      };
    };
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
      fill.symbol = " ";
      terraform = {
        format = "[💠 $version]($style) ";
      };
      golang = {
        format = "[ $version](bold blue)";
      };
      nodejs = {
        format = "[ $version](bold green) ";
      };
      rust = {
        format = "[⚙️$version](red bold)";
      };
      lua = {
        format = "[🌙 $version](bold white) ";
      };
      nix_shell = {
        format = "[❄️ $version](bold white) ";
      };
    };
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "http://atuin.local.net";
      search_mode = "fuzzy";
      search_mode_shell_up_key_binding = "fuzzy";
      keymap_mode = "vim-insert";
      style = "compact";
      secrets_filter = true;
    };
  };
}
