{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "mvaldes14";
        email = "elxilote@gmail.com";
      };
    };
    hooks = {
      commit-msg = pkgs.writeShellScript "commit-msg" ''
        # Conventional Commits validation hook
        # Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert

        commit_msg_file="$1"
        commit_msg=$(cat "$commit_msg_file")

        # Regex pattern for conventional commits
        # Format: type(optional-scope): description
        # Optional: body and footer
        pattern="^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert)(\(.+\))?(!)?: .{1,}$"

        # Get the first line (subject) of the commit message
        first_line=$(echo "$commit_msg" | head -n1)

        # Skip merge commits
        if echo "$first_line" | grep -qE "^Merge "; then
          exit 0
        fi

        # Validate against conventional commits pattern
        if ! echo "$first_line" | grep -qE "$pattern"; then
          echo "ERROR: Commit message does not follow Conventional Commits format."
          echo ""
          echo "Expected format: <type>(<optional-scope>): <description>"
          echo ""
          echo "Valid types:"
          echo "  feat:     A new feature"
          echo "  fix:      A bug fix"
          echo "  docs:     Documentation only changes"
          echo "  style:    Changes that do not affect the meaning of the code"
          echo "  refactor: A code change that neither fixes a bug nor adds a feature"
          echo "  perf:     A code change that improves performance"
          echo "  test:     Adding missing tests or correcting existing tests"
          echo "  build:    Changes that affect the build system or dependencies"
          echo "  ci:       Changes to CI configuration files and scripts"
          echo "  chore:    Other changes that don't modify src or test files"
          echo "  revert:   Reverts a previous commit"
          echo ""
          echo "Examples:"
          echo "  feat: add user authentication"
          echo "  fix(auth): resolve login timeout issue"
          echo "  docs: update README with installation steps"
          echo "  feat!: breaking change in API"
          echo ""
          echo "Your commit message was:"
          echo "  $first_line"
          exit 1
        fi
      '';
    };
  };
}
