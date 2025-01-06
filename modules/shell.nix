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

  programs.nnn = {
    enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      os.editorPreset = "nvim";
      gui.theme = {
        activeBorderColor = ["#89b4fa" "bold"];
        inactiveBorderColor = ["#a6adc8" "bold"];
        optionsTextColor = ["#89b4fa"];
        selectedLineBgColor = ["#313244"];
        selectedRangeBgColor = ["#313244"];
        cherryPickedCommitBgColor = ["#45475a"];
        cherryPickedCommitFgColor = ["#89b4fa"];
        unstagedChangesColor = ["#f38ba8"];
        defaultFgColor = ["#cdd6f4"];
        searchingActiveBorderColor = ["#f9e2af"];
      };
      git = {
        paging = {
          colorArg = "always";
          useConfig = false;
        };
      };
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
      add_newline = false;
      format = lib.concatStrings [
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$kubernetes"
        "$helm"
        "$cmd_duration"
        "$fill"
        "$terraform"
        "$pulumi"
        "$golang"
        "$nodejs"
        "$rust"
        "$lua"
        "$ocaml"
        "$aws"
        "nix_shell"
        "\n$character"
      ];
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
      fill.symbol = " ";
      terraform = {
        format = "[💠 $version]($style) ";
        disabled = false;
        detect_folders = [".terraform"];
      };
      golang = {
        symbol = " ";
        format = "[$symbol($version )]($style)";
      };
      nodejs = {
        format = "[$version](bold green) ";
      };
      rust = {
        format = "[⚙️$version](red bold)";
      };
      ocaml = {
        format = "[🐫 $version](bold yellow) ";
        detect_files = ["dune"];
      };
      lua = {
        format = "[🌙 $version](bold white) ";
        detect_files = ["lua"];
      };
      nix_shell = {
        format = "[❄️ $name](bold white) ";
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
