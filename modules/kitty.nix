{ config, pkgs, ... }:
let
  kittyConfig = ''
    font_family FiraCode Nerd Font
    font_size 20.0
    background #1e1e2e
    foreground #cdd6f4
    cursor #f5e0dc
    scrollback_lines 10000
    enable_audio_bell no
    map ctrl+shift+t new_tab
    map ctrl+shift+w close_tab
  '';
in {
  # environment.systemPackages = [ pkgs.kitty ];
  
  system.activationScripts.kittyConfig.text = ''
    mkdir -p /home/krecikowa/.config/kitty
    echo "${kittyConfig}" > /home/krecikowa/.config/kitty/kitty.conf
    chown -R krecikowa:krecikowa /home/krecikowa/.config/kitty
  '';
}
