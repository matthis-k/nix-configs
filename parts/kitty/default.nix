{
  homeManager =
    { pkgs, ... }:
    {
      programs.kitty.enable = true;
      programs.kitty.themeFile = "Catppuccin-Mocha";
      programs.kitty.font = {
        name = "Hack Nerd Font";
        size = 10;
        package = pkgs.nerdfonts.override {
          fonts = [
            "Hack"
          ];
        };
      };
      programs.kitty.settings = {
        mouse_hide_wait = 0;
        confirm_os_window_close = 0;
        enable_audio_bell = false;
      };
    };
}
