{
  nixos =
    { pkgs, ... }:
    {
      programs = {
        command-not-found.enable = false;
        nix-index.enableFishIntegration = false;
      };
    };
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
        fishPlugins.z
        hyperfine
      ];
      programs = {
        bat.enable = true;
        bottom.enable = true;
        command-not-found.enable = false;
        nix-index.enableFishIntegration = false;
        git.enable = true;
        delta.enable = true;
        delta.enableGitIntegration = true;
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
            git.pagers = [
              {
                pager = "${pkgs.delta}/bin/delta --dark --paging=never";
                colorArg = "always";
              }
              {
                externalDiffCommand = "${pkgs.difftastic}/bin/difft --color=always";
              }
            ];
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

          function fish_user_key_bindings
            fish_vi_key_bindings
            bind -M default \cZ 'fg'
            bind -M insert \cZ 'fg'
          end

          fish_config theme choose "Catpuccin-Mocha"
          eval (${pkgs.openssh}/bin/ssh-agent -c) > /dev/null
          for ssh_key in (${pkgs.fd}/bin/fd --base-directory ~/.ssh/ "id_*" -E "id_*.pub" -a)
              ${pkgs.openssh}/bin/ssh-add $ssh_key &> /dev/null
          end
        '';
        fish.shellAliases = {
          c = "z";
          cat = "bat";
          ci = "zi";
          du = "dust";
          find = "fd";
          grep = "rg";
          lg = "lazygit";
          ls = "eza";
          n = "nvim";
          nd = "nvimdev";
          yy = "yazi";
        };

      };

      xdg.configFile."fish/themes/Catpuccin-Mocha.theme" = {
        source = ./Catppuccin-Mocha.theme;
      };
    };
}
