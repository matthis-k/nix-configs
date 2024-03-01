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
    bat
    bottom
    delta
    difftastic
    du-dust
    eza
    fd
    fishPlugins.colored-man-pages
    fishPlugins.fzf-fish
    fishPlugins.sponge
    fishPlugins.z
    fzf
    hyperfine
    lazygit
    ripgrep
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
    ls = "exa";
    du = "dust";
    find = "fd";
    yy = "yazi";
    cat = "bat";
    grep = "rg";
  };

  home.sessionVariables = {
    SYS_FLAKE = "$HOME/nix-configs/";
    SYS_FLAKE_HOST = "${host}";
  };

  programs.fish.functions = {
    rebuild = ''sudo nixos-rebuild switch --flake "$SYS_FLAKE#$SYS_FLAKE_HOST"'';
  };

  programs.lazygit = {
    enable = true;
    settings = {
        gui = {
            nerdFontsVersion = "3";
        };
        git = {
            paging = {
                pager = "delta --dark --paging=never";
            };
        };
    };
  };

  xdg.configFile."fish/themes/Catpuccin-Mocha.theme" = {source = color.files pkgs ./Catppuccin-Mocha.theme;};

  programs.yazi.enable = true;
  programs.zoxide.enable = true;
}
