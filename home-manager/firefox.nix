{
  pkgs,
  vars,
  inputs,
  ...
}: {
  programs.firefox = {
    package = pkgs.firefox-beta-bin;
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
    };
  };
}
