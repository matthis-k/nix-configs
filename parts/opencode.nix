{
  homeManager =
    { opencode-openai-codex-auth, pkgs, ... }:
    let
      modernConfig = builtins.fromJSON (
        builtins.readFile (opencode-openai-codex-auth + "/config/opencode-modern.json")
      );

      mergedConfig = modernConfig // {
        theme = "catppuccin";
      };
    in
    {
      xdg.configFile."opencode/opencode.json".text = builtins.toJSON mergedConfig;
      home.packages = with pkgs; [ opencode ];
    };
}
