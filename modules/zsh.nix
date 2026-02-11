{
  pkgs,
  config,
  ...
}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--preview-window=right:60%"
      "--ansi"
    ];
    changeDirWidgetCommand = "fd --type d --hidden --exclude .git";
    changeDirWidgetOptions = ["--preview 'eza --tree {} | head -200'"];
    fileWidgetCommand = "fd --type f --hidden --exclude .git";
  };

  programs.zsh = {
    enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    initContent = ''
      # Zsh options from zsh_options
      setopt AUTO_LIST
      setopt AUTO_MENU
      setopt AUTO_PARAM_KEYS
      setopt AUTO_PARAM_SLASH
      setopt AUTO_PUSHD
      setopt AUTOPUSHD
      setopt BRACE_CCL
      setopt CHASE_LINKS
      setopt EXTENDED_GLOB
      setopt GLOBDOTS
      setopt HIST_NO_STORE
      setopt HIST_REDUCE_BLANKS
      setopt INC_APPEND_HISTORY
      setopt LIST_PACKED
      setopt LIST_TYPES
      setopt MAGIC_EQUAL_SUBST
      setopt MULTIOS
      setopt NO_CLOBBER
      setopt NOAUTOREMOVESLASH
      setopt NOLISTBEEP
      setopt PATH_DIRS
      setopt PUSHD_IGNORE_DUPS

      # Custom environment
      export no_proxy='*'

      # Functions from zsh_functions
      addToPath() {
        if [[ "$PATH" != *"$1"* ]]; then
          export PATH=$PATH:$1
        fi
      }

      awsp() {
        file=$(cat ~/.aws/config | grep '\[' | sed 's/\[//g' | sed 's/\]//g')
        profile=$(echo "$file" | fzf --height 40% --layout=reverse --border --preview "echo {}" --preview-window=up:1:hidden)
        if [ -n "$profile" ]; then
          echo "Changing Profile to $profile"
          export AWS_PROFILE="$profile"
          export AWS_DEFAULT_PROFILE="$profile"
        else
          echo "No profile selected"
        fi
      }

      ghpr() {
        echo "List of open PRs:"
        PAGER="" gh search prs --author=@me --state open
      }

      how() {
        if ! rg --version >/dev/null 2>&1; then
          echo "ripgrep is not installed"
        fi
        if [ -z "$1" ]; then
          echo "Usage: how <search_term>"
          return 1
        fi
        local search_term="$1"
        local wiki_path="$HOME/Obsidian/wiki/"
        local selected=$(
          rg --smart-case \
            --files-with-matches \
            --vimgrep \
            --no-messages \
            -g '*.md' \
            "$search_term" \
            $wiki_path | fzf \
            --preview-window 'bottom:60%,wrap,border:rounded' \
            --preview \
            "highlight -O ansi -l {} 2> /dev/null \
             | rg --smart-case --colors 'match:bg:yellow' --ignore-case --pretty --no-line-number --no-column --context 10 '$search_term' \
             || rg --smart-case --ignore-case --pretty --no-line-number --no-column --context 10 '$search_term' {}
            "
        )
        if [ "$selected" = "" ]; then
          echo 'no documents found'
          return 1
        fi
        nvim $selected
      }

      kcc() {
        kubectl config use-context $(kubectl config get-contexts | awk 'NR > 1 {print $1}' | fzf --no-preview)
      }

      WORK_REPO='signoz/platform-pod'

      gli() {
        gh issue list --assignee @me --state open -R $WORK_REPO
      }

      gci() {
        gh issue create -R $WORK_REPO --assignee @me
      }

      gcu() {
        issue=$(gh issue list --assignee @me --state open -R $WORK_REPO | fzf --no-preview | awk '{ print $1 }')
        gh issue comment -R "$WORK_REPO" $issue
      }

      # Add custom paths
      addToPath $HOME/.local/bin
      addToPath $HOME/go/bin
      addToPath /opt/homebrew/bin
      addToPath /Applications/Obsidian.app/Contents/MacOS/
    '';

    shellAliases = {
      # Editor
      v = "nvim";
      vwiki = "pushd ~/Obsidian/wiki && nvim";
      obs = "obsidian";

      # Navigation
      cd = "z";
      dot = "cd $DOTFILES";
      cdr = "cd $(find ~/git -maxdepth 3 -type d | fzf --no-preview)";

      # Tools
      n = "nnn";
      cat = "bat";
      lg = "lazygit";
      kk = "k9s";
      du = "ncdu";

      # CLI shortcuts
      s = "doppler run";
      tf = "terraform";
      k = "kubectl";
      pip = "pip3";
      python = "python3";

      # Tmux
      cdg = "~/.local/bin/tmux-layout.sh";
      tmks = "~/.local/bin/tmux-sessionkiller.sh";
      tmkw = "~/.local/bin/tmux-windowkiller.sh";

      # Eza (ls replacement)
      ll = "eza -lrh --icons -t=modified --git";
      ls = "eza -lh --git";
      lr = "eza -lrT";

      # Fzf with preview
      fzf = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'";

      # Misc
      weather = "curl 'wttr.in/55318?m'";
      smsg = "git diff --staged | opencode run 'Generate a concise and imperative Git commit message do not include any reference to opencode, do not explain it' | git commit -F -";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "aws" "vi-mode" "kubectl" "fzf" "ansible" "zoxide" "helm"];
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "cat";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      XDG_CONFIG_HOME = "$HOME/.config";
      DOTFILES = "$HOME/git/dotfiles";
      ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";
    };

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
  };
}
