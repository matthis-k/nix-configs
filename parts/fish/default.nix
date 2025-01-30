{
  homeManager =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        ./starship.nix
      ];
      home.packages = with pkgs; [
        fishPlugins.colored-man-pages
        fishPlugins.fzf-fish
        fishPlugins.sponge
        fishPlugins.z
        hyperfine
      ];
      programs = {
        bat.enable = true;
        bottom.enable = true;
        git = {
          enable = true;
          delta.enable = true;
        };
        eza = {
          enable = true;
          icons = "auto";
        };
        fd.enable = true;
        fzf.enable = true;
        lazygit = {
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
        ripgrep.enable = true;
        yazi.enable = true;
        zoxide.enable = true;

        fish.enable = true;
        fish.interactiveShellInit = ''
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
        fish.shellAliases = {
          lg = "lazygit";
          ls = "exa";
          du = "dust";
          find = "fd";
          yy = "yazi";
          cat = "bat";
          grep = "rg";
        };

      };

      xdg.configFile."fish/themes/Catpuccin-Mocha.theme" = {
        source = ./Catppuccin-Mocha.theme;
      };
    };
}
