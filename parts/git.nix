{
  homeManager =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = "matthis-k";
          user.email = "matthis.kaelble@gmail.com";

          pull.rebase = false;
          merge.conflictstyle = "diff3";
          init.defaultBranch = "main";
          core.editor = "nvim";
        };
      };
    };
}
