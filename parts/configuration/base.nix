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
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts.fira-mono
        nerd-fonts.go-mono
        nerd-fonts.hack
        nerd-fonts.inconsolata
        nerd-fonts.jetbrains-mono
        nerd-fonts.roboto-mono
        nerd-fonts.sauce-code-pro
        pkgs.font-awesome
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
        gh
        imv
        mpv
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
      system.stateVersion = "25.05";
    };
}
