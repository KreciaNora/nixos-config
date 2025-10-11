{ config, pkgs, ... }:
{
programs.kitty = {
  enable = true;
  theme = "Catppuccin-Mocha";
  font = {
    name = "JetBrainsMono Nerd Font";
    size = 12;
  };
  settings = {
    background_opacity = "0.95";
    window_padding_width = 10;
  };
};
}
