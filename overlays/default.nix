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
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
