{
  inputs,
  color,
  ...
}: {
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      inherit color inputs;
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
