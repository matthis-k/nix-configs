{
  inputs,
  color,
  ...
}: {
  additions = final: _prev:
    import ../pkgs rec {
      pkgs = final;
      inherit color;
    };

  modifications = final: prev: {
    blueberry =
      prev.blueberry.overrideAttrs
      (oldAttrs: {
        patches = oldAttrs.patches or [] ++ [./blueberry/blueberry-tray-fix.patch];
        buildInputs = oldAttrs.buildInputs ++ [prev.libappindicator-gtk3];
      });
    waybar = inputs.waybar.packages.${prev.system}.default;
    hyprland = inputs.hyprland.packages.${prev.system}.hyprland;
    hyprlandPlugin.hyprexpo = inputs.hyprland-plugins.packages.${prev.system}.hyprexpo;
    hyprlandPlugin.hyprspace = inputs.Hyprspace.packages.${prev.system}.Hyprspace;
    hyprlock = inputs.hyprlock.packages.${prev.system}.hyprlock;
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
