{
  self,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.plymouth.enable = true;
  hardware.bluetooth.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1920x1020";
  boot.loader.grub.gfxmodeBios = "1920x1020";
  boot.loader.grub.font = lib.mkForce "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HackNerdFontMono-Regular.ttf";
  boot.plymouth.font = lib.mkForce "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/HackNerdFontMono-Regular.ttf";

  boot.kernelParams = [
    "splash"
    "quiet"
    "udev.log_level=3"
  ];
  boot.initrd.systemd.enable = true;

  boot.loader.grub.extraEntries = ''
    menuentry "Firmware settings" --class efi {
        fwsetup
    }
    menuentry "Reboot" --class restart {
      reboot
    }
    menuentry "Shutdown" --class shutdown {
      halt
    }
  '';

  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;
  nix = {
    package = pkgs.lix;
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
      (lib.filterAttrs (_: lib.isType "flake")) inputs
    );
    nixPath = [ "/etc/nix/path" ];
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 14d";
    optimise.automatic = true;
    optimise.dates = [ "weekly" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operator"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  networking.hostName = "matthisk-laptop";
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [
        ""
        "${pkgs.networkmanager}/bin/nm-online -q"
      ];
    };
  };
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.preload.enable = true;
  services.dbus.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  console = {
    keyMap = "de";
  };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "matthisk";
  services.displayManager.defaultSession = "hyprland-uwsm";

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  services.desktopManager.plasma6.enable = true;

  programs.firefox.enable = true;

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
    wl-clipboard
    kitty
    nvim
    nvimdev
    hyprpolkitagent
    libsForQt5.qt5ct
    hyprshell
    gjs

    ags.ags
    ags.astal
    ags.docs
    ags.io
    ags.gjs
    ags.astal3
    ags.astal4
    ags.apps
    ags.auth
    ags.battery
    ags.bluetooth
    ags.cava
    ags.greet
    ags.hyprland
    ags.mpris
    ags.network
    ags.notifd
    ags.powerprofiles
    ags.river
    ags.tray
    ags.wireplumber

    grimblast
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  systemd.user.services.hyprpolkitagent = {
    enable = true;
    description = "HyprPolkitAgent Service";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  nixpkgs.overlays = [
    inputs.nvim-flake.overlays.default
    inputs.nvim-flake.overlays.nvimdev
    inputs.ags-flake.overlays.default
    inputs.hyprland.overlays.default
    inputs.hyprpicker.overlays.default
  ];

  users.extraGroups.libvirtd.members = [ "matthisk" ];
  users.extraGroups.docker.members = [ "matthisk" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;
  programs.virt-manager.enable = true;

  programs.nix-ld.enable = true;

  users.users = {
    matthisk = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
      ];
      useDefaultShell = true;
    };
  };
  system.stateVersion = "24.11"; # Did you read the comment?
}
