{
  nixos =
    { pkgs, ... }:
    {
      environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };

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
        kitty
        nvim
        nvimdev
        libsForQt5.qt5ct
      ];

      programs.fish.enable = true;
      users.defaultUserShell = pkgs.fish;

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
    };
}
