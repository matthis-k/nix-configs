{ pkgs, home-manager, vars, ... }: {
  programs.nano.enable = false;
  programs.neovim = {
    defaultEditor = true;
    package = pkgs.neovim-nightly;
    enable = false;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git

    neovim-nightly

    rustup
    rnix-lsp
    lua-language-server
    stylua
    libclang
    shellcheck
    shfmt
    shellharden

    eza
    bat
    du-dust
    fd
    ripgrep
    lazygit
    hyperfine
    delta
    bottom
  ];
}
