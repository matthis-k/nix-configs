{
  nixos =
    { pkgs, inputs, ... }:
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
    };
}
