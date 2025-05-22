{
  homeManager =
    { ... }:
    {
      programs.git = {
        enable = true;
        userName = "matthis-k";
        userEmail = "matthis.kaelble@gmail.com";

        extraConfig = {
          pull.rebase = false;
          merge.conflictstyle = "diff3";
          init.defaultBranch = "main";
          core.editor = "nvim";
        };
      };
    };
}
