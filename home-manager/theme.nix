{
  pkgs,
  config,
  ...
}: {
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";
  catppuccin.accent = "blue";
  catppuccin.pointerCursor.enable = true;
  catppuccin.pointerCursor.accent = "blue";
  catppuccin.pointerCursor.flavor = "mocha";
  gtk.enable = true;
  gtk.catppuccin.enable = true;
  gtk.catppuccin.flavor = "mocha";
  gtk.catppuccin.accent = "blue";
  gtk.catppuccin.icon.enable = true;
  gtk.catppuccin.icon.flavor = "mocha";
  gtk.catppuccin.icon.accent = "blue";
  gtk.catppuccin.size = "standard";
  qt.enable = true;
  qt.style.catppuccin.enable = true;
  qt.style.catppuccin.apply = true;
  qt.style.catppuccin.flavor = "mocha";
  qt.style.catppuccin.accent = "blue";
  qt.style.name = "kvantum";
  qt.platformTheme.name = "kvantum";
  i18n.inputMethod.fcitx5.catppuccin.apply = true;
  i18n.inputMethod.fcitx5.catppuccin.flavor = "mocha";
  i18n.inputMethod.fcitx5.catppuccin.enable = true;
  programs.alacritty.enable = true;
  programs.alacritty.catppuccin.enable = true;
  programs.alacritty.catppuccin.flavor = "mocha";
  programs.bat.enable = true;
  programs.bat.catppuccin.enable = true;
  programs.bat.catppuccin.flavor = "mocha";
  programs.bottom.enable = true;
  programs.bottom.catppuccin.enable = true;
  programs.bottom.catppuccin.flavor = "mocha";
  programs.fish.enable = true;
  programs.fish.catppuccin.enable = true;
  programs.fish.catppuccin.flavor = "mocha";
  programs.fzf.enable = true;
  programs.fzf.catppuccin.enable = true;
  programs.fzf.catppuccin.flavor = "mocha";
  programs.git.delta.enable = true;
  programs.git.delta.catppuccin.enable = true;
  programs.git.delta.catppuccin.flavor = "mocha";
  programs.imv.enable = true;
  programs.imv.catppuccin.enable = true;
  programs.imv.catppuccin.flavor = "mocha";
  programs.kitty.enable = true;
  programs.kitty.catppuccin.enable = true;
  programs.kitty.catppuccin.flavor = "mocha";
  programs.lazygit.enable = true;
  programs.lazygit.catppuccin.enable = true;
  programs.lazygit.catppuccin.flavor = "mocha";
  programs.lazygit.catppuccin.accent = "blue";
  programs.mpv.enable = true;
  programs.mpv.catppuccin.enable = true;
  programs.mpv.catppuccin.flavor = "mocha";
  programs.mpv.catppuccin.accent = "blue";
  programs.neovim.catppuccin.enable = false;
  programs.yazi.enable = true;
  programs.yazi.catppuccin.enable = true;
  programs.yazi.catppuccin.flavor = "mocha";
}
