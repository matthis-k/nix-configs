{
  pkgs,
  vars,
  inputs,
  ...
}: {
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
        :root {
            --navbar-height: 48px;
            --wc-height: 16px;
            --wc-left-margin: 10px;
            --wc-red: hsl(-10, 90%, 60%);
            --wc-yellow: hsl(50, 90%, 60%);
            --wc-green: hsl(160, 90%, 40%);
            --sidebar-width: 250px;
            --transition-duration: 0.2s;
            --transition-ease: ease-out;
        }

        /* hide tabline */
        #navigator-toolbox {
            -moz-window-dragging: drag;
        }

        #titlebar {
            appearance: none !important;
        }

        #TabsToolbar .toolbar-items {
            display: none !important;
        }

        #TabsToolbar.browser-toolbar {
            display: none !important;
        }

        #nav-bar {
            padding: calc((var(--navbar-height) - 40px) / 2) 0;
        }

        #urlbar {
            --urlbar-toolbar-height: 40px !important;
            z-index: 200 !important;
        }

        #private-browsing-indicator-with-label {
            display: none !important;
        }

        #pageAction-urlbar-_testpilot-containers {
            display: none !important;
        }

        .titlebar-button>.toolbarbutton-icon {
            visibility: hidden;
        }

        .titlebar-button {
            padding: 0 !important;
            height: var(--wc-height) !important;
            min-height: var(--wc-height) !important;
            width: var(--wc-height) !important;
            min-width: var(--wc-height) !important;
            border-radius: 50%;
            opacity: 0.7 !important;
        }

        .titlebar-button:hover {
            transform: scale(1.1);
            opacity: 1 !important;
            cursor: pointer;
        }

        .titlebar-buttonbox {
            display: flex;
            margin-right: var(--wc-height);
            gap: var(--wc-height);
        }

        .titlebar-close {
            background: var(--wc-red) !important;
        }

        .titlebar-min {
            background: var(--wc-yellow) !important;
        }

        .titlebar-max,
        .titlebar-restore {
            background: var(--wc-green) !important;
        }

        #main-window[titlepreface*="🦊 "] .titlebar-button {
          height: 40px !important;
        }

        #main-window[titlepreface*="🦊 "] #nav-bar {
          margin-top: -40px;
          margin-right: 137px;
          box-shadow: none !important;
        }
        #main-window[titlepreface*="🦊 "] #titlebar-spacer {
          background-color: var(--chrome-secondary-background-color);
        }

        #main-window[titlepreface*="🦊 "] #titlebar-buttonbox-container {
          background-color: var(--chrome-secondary-background-color);
        }

        #main-window[titlepreface*="🦊 "] .titlebar-color {
          background-color: var(--toolbar-bgcolor);
        }
      '';
    };
  };
}
