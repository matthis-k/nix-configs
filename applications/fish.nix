{ pkgs, config, vars, home-manager, ... }: {
  users.defaultUserShell = pkgs.fish;
  environment.systemPackages = with pkgs; [
    eza
    bat
    du-dust
    fd
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
  home-manager.users.${vars.username} = {
    programs.fish.enable = true;
    programs.fish.interactiveShellInit = ''
      set fish_greeting
    '';
    programs.broot.enable = true;
    programs.navi.enable = true;
    programs.starship.enable = true;
    programs.thefuck.enable = true;
    programs.yazi.enable = true;
    programs.zoxide.enable = true;
    programs.zellij.enable = true;



    programs.starship.settings = {
      add_newline = false;
      format = "[](bright-black)$username$hostname[](bright-black)[─](bold bright-black)$directory$git_branch$git_status[$fill](bold bright-black)$cmd_duration[─](bold bright-black)$time[](bright-black)\n$character";

      fill = {
        symbol = "─";
        style = "$style";
      };

      hostname = {
        format = "[ @$hostname ](bold yellow bg:bright-black)";
        ssh_symbol = "󰖟";
      };

      username = {
        format = "[ $user ](bold blue bg:bright-black)";
        show_always = true;
      };

      cmd_duration = {
        min_time = 500;
        format = "[[[](bright-black) [$duration](bold yellow bg:bright-black) [](bright-black)](bg:bright-black)](bold yellow bg:bright-black)";
      };

      directory = {
        truncation_length = 3;
        home_symbol = "󰋜 ";
        format = "[](bright-black)[ $path ](yellow bg:bright-black)[$read_only]($read_only_style)[](bright-black)";

        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = "󰇚 ";
          "Music" = " ";
          "Pictures" = "󰋩 ";
        };
      };

      git_branch = {
        symbol = "󰘬 ";
        format = "[[[─](bright-black) $symbol $branch](bold green bg:bright-black)]($style)";
      };

      git_status = {
        format = "[[[ ](bg:bright-black)($all_status$ahead_behind) ](green bg:bright-black)[](bright-black)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg: bright-black";
        format = "[[](bright-black)[  $time ](blue bg:bright-black)]($style)";
      };

      character = {
        success_symbol = "[ ](bold green) ";
        error_symbol = "[ ](bold red) ";
      };
    };
  };
}


