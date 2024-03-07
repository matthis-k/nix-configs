{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    inputs.home-manager.nixosModules.home-manager
    ./bootup.nix
    ./gdm.nix
    ./locales.nix
    ./nix-settings.nix
    ./services.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
        "FiraMono"
        "Go-Mono"
        "Hack"
        "Inconsolata"
        "Iosevka"
        "IosevkaTerm"
        "JetBrainsMono"
        "RobotoMono"
        "SourceCodePro"
        "Terminus"
      ];
    })
    font-awesome
  ];
  environment.systemPackages = with pkgs; [
    autoconf
    automake
    busybox
    cmake
    git
    gnumake
    jq
    libcxx
    libgcc
    libtool
    pkg-config
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "electron-24.8.6"
      ];
    };
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  users.extraGroups.vboxusers.members = ["matthisk"];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;

  programs.nix-ld.enable = true;

  users.users = {
    matthisk = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = ["networkmanager" "wheel" "video" "audio"];
      useDefaultShell = true;
    };
  };

  system.stateVersion = "23.11";
}
