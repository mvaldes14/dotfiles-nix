{...}: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "mvaldes14";
        email = "elxilote@gmail.com";
      };
    };
  };
}
