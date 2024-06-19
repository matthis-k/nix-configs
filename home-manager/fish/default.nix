{
  pkgs,
  color,
  config,
  host,
  ...
}: {
  imports = [
    ./zellij.nix
    ./starship.nix
  ];
  home.packages = with pkgs; [
    eza
    bat
    du-dust
    fd
    fzf
    ripgrep
    lazygit
    hyperfine
    delta
    bottom
    fishPlugins.fzf-fish
    fishPlugins.z
    fishPlugins.sponge
    fishPlugins.colored-man-pages
  ];
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    set fish_greeting

    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block
    fish_vi_key_bindings

    fish_config theme choose "Catpuccin-Mocha"
    eval (ssh-agent -c) > /dev/null
    for ssh_key in (fd --base-directory ~/.ssh/ "id_*" -E "id_*.pub" -a)
        ssh-add $ssh_key &> /dev/null
    end
  '';
  programs.fish.shellAliases = {
    lg = "lazygit";
  };

  home.sessionVariables = {
    SYS_FLAKE = "$HOME/nix-configs/";
    SYS_FLAKE_HOST = "${host}";
  };

  programs.fish.functions = {
    rebuild-system = ''sudo nixos-rebuild switch --flake "$SYS_FLAKE#$SYS_FLAKE_HOST"'';
    rebuild-home = ''home-manager switch --flake "$SYS_FLAKE#$USER@$SYS_FLAKE_HOST"'';
  };

  xdg.configFile."fish/themes/Catpuccin-Mocha.theme" = {source = color.files pkgs ./Catppuccin-Mocha.theme;};

  programs.yazi.enable = true;
  programs.zoxide.enable = true;
}
