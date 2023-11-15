{ pkgs, vars, home-manager, inputs, ... }: {
  home-manager.users.${vars.username} = {
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
        isDefault = true;
        userChrome = ''
          @import "${
              builtins.fetchGit {
                  url = "https://github.com/say4n/oneline";
                  ref = "main";
                  rev = "2907d6681c7f90d268a8335b6addf71acddd4ac5";
              }
            }/chrome/userChrome.css";
        '';
      };
    };
  };
}
