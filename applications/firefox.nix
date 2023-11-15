{ pkgs, vars, home-manager, inputs, ... }: {
  home-manager.users.${vars.username} = {
    home.file.".mozilla/firefox/nix-user-profile/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;


    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.tabs.drawInTitlebar" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.uidensity" = 0;
        };
        userChrome = ''
          @import "firefox-gnome-theme/userChrome.css";
        '';
        userContent = ''
          @import "firefox-gnome-theme/userContent.css";
        '';
      };
    };
  };
}
