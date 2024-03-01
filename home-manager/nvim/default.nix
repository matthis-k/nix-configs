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
    extraLuaPackages = ps: [ps.magick ps.luautf8 ps.fzy];
    extraPackages = with pkgs; [
      alejandra
      bottom
      curl
      fd
      imagemagick
      lazygit
      libclang
      lua-language-server
      luarocks
      lua5_1
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
      typescript
      nodePackages_latest.typescript-language-server
      vscode-langservers-extracted
      wget
    ];
  };

  home.activation.linkNeovimConfig =
    lib.hm.dag.entryAfter ["writeBoundary"]
    ''
      rm -rf ${config.home.homeDirectory}/.config/nvim
      ln -s ${config.home.homeDirectory}/nix-configs/configs/nvim ${config.home.homeDirectory}/.config/nvim
    '';
}
