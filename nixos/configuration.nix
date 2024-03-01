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
    ./bootup.nix
    ./sddm.nix
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
        "JetBrainsMono"
        "RobotoMono"
        "SourceCodePro"
        "Terminus"
      ];
    })
    font-awesome
  ];

  # catppuccin.enable = true;
  # catppuccin.accent = "blue";
  # catppuccin.flavor = "mocha";
  # console.catppuccin.enable = true;
  # console.catppuccin.flavor = "mocha";

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  environment.systemPackages = with pkgs; [
    autoconf
    automake
    bash
    binutils
    busybox
    bzip2
    cargo
    clang
    cmake
    coreutils
    diffutils
    findutils
    gawk
    gcc
    git
    gnum4
    gnumake
    go
    gradle
    gzip
    jq
    libcxx
    libgcc
    libtool
    maven
    mercurial
    nodejs
    openjdk
    patch
    python3
    python3Packages.pip
    python3Packages.virtualenv
    ruby
    rustc
    subversion
    yarn
    pkg-config
    home-manager
    jetbrains.clion
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      inputs.nur.overlay
      inputs.rust-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "nix-2.16.2"
        "electron-24.8.6"
        "clion"
      ];
    };
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  users.extraGroups.libvirtd.members = ["matthisk"];
  users.extraGroups.docker.members = ["matthisk"];
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;

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

  system.stateVersion = "24.11";
}
