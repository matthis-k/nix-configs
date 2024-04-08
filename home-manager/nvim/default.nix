{pkgs, ...}: {
  programs.neovim = {
    defaultEditor = true;
    package = pkgs.neovim-nightly;
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
      cargo
      curl
      fd
      imagemagick
      lazygit
      libclang
      lua-language-server
      nixd
      ollama
      ripgrep
      rust-bin.beta.latest.default
      shellcheck
      shellharden
      shfmt
      stylua
      ueberzugpp
      wget
    ];
  };

  xdg.configFile."nvim" = {source = ./config;};
}
