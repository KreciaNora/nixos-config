{ config, pkgs, ... }:
{
programs.kitty = {
  enable = true;
  theme = "Catppuccin-Mocha";
  font = {
    name = "Comic Mono";
    size = 12;
  };
  settings = {
    background_opacity = "0.95";
    window_padding_width = 10;
    adjust_line_height = "100%";   
    adjust_column_width = "100%";  
  };
};
}
