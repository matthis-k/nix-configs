{
  homeManager =
    { pkgs, ... }:
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/plain" = [ "nvim.desktop" ];
          "text/html" = [ "zen-browser.desktop" ];
          "application/pdf" = [ "zen-browser.desktop" ];
          "image/png" = [ "imv.desktop" ];
          "image/jpeg" = [ "imv.desktop" ];
          "image/gif" = [ "imv.desktop" ];
          "video/mp4" = [ "mpv.desktop" ];
          "audio/*" = [ "mpv.desktop" ];
        };
      };
    };
}