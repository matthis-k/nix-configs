{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.neovim = {
    package = pkgs.unstable.neovim-unwrapped;
    defaultEditor = true;
    enable = true;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    vimdiffAlias = true;
    viAlias = true;
    extraLuaPackages = ps: [ps.magick ps.luautf8];
    extraPackages = with pkgs; [
      alejandra
      bottom
      curl
      fd
      imagemagick
      lazygit
      libclang
      lua-language-server
      nixd
      ollama
      ripgrep
      rust-analyzer
      (rust-bin.beta.latest.default.override {
        extensions = ["rust-src"];
      })
      shellcheck
      shellharden
      shfmt
      stylua
      ueberzugpp
      wget
    ];
  };

  home.activation.linkNeovimConfig =
    lib.hm.dag.entryAfter ["writeBoundary"]
    ''
      rm -rf ${config.home.homeDirectory}/.config/nvim
      ln -s ${config.home.homeDirectory}/nix-configs/home-manager/nvim/config/ ${config.home.homeDirectory}/.config/nvim
    '';
}
