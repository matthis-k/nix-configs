{
  nixos =
    {
      pkgs,
      inputs,
      lib,
      ...
    }:
    {
      qt.enable = true;
      environment.systemPackages = with pkgs; [
        inputs.quickshell.packages.${pkgs.system}.default
        quickde
        kdePackages.qtdeclarative
        kdePackages.qt3d
        kdePackages.qt6ct
        kdePackages.qtbase
        kdePackages.qttools
        kdePackages.qt5compat
      ];
      environment.variables = {
        QS_ICON_THEME = "Papirus";
      };
      nixpkgs.overlays = [
        (final: prev: {
          inherit (inputs.qs-flake.packages.${pkgs.system}) quickde;
        })
      ];

      systemd.user.services.quickde =
        let
          waitNM = pkgs.writeShellScript "wait-networkmanager" ''
            set -eu
            for i in $(seq 1 50); do
              if ${pkgs.systemd}/bin/busctl --system --timeout=1 list \
                | ${pkgs.gnugrep}/bin/grep -q org.freedesktop.NetworkManager
              then
                exit 0
              fi
              sleep 0.2
            done
            echo "NetworkManager not ready on D-Bus" >&2
            exit 1
          '';
        in
        {
          description = "QuickDE Bar";
          wantedBy = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];

          serviceConfig = {
            ExecStartPre = [ "${waitNM}" ];
            ExecStart = "${pkgs.quickde}/bin/quickde";
            Restart = "on-failure";
            RestartSec = 0.5;

            Environment = [
              "PATH=${
                lib.makeBinPath [
                  pkgs.networkmanager
                  pkgs.coreutils
                  pkgs.systemd
                  pkgs.gnugrep
                ]
              }:/run/current-system/sw/bin"
              "XDG_CURRENT_DESKTOP=Hyprland"
            ];
          };
        };
    };
}
