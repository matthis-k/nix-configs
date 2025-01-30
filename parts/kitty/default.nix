{
  homeManager =
    { pkgs, ... }:
    {
      programs.kitty.enable = true;
      programs.kitty.themeFile = "Catppuccin-Mocha";
      programs.kitty.font = {
        name = "Hack Nerd Font Mono";
        size = 10;
        package = pkgs.nerdfonts.override {
          fonts = [
            "FiraCode"
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
