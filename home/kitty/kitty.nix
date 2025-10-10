{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 16;
    settings = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      cursor = "#f5e0dc";
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
    };
  };
}

