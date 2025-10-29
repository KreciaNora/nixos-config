{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {

      monitor = [
        ",preferred,auto,auto"
        "eDP-1,1920x1080@60,0x0,1"
        "HDMI-A-1,1920x1080@75,1920x0,1"
      ];
      
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";
      
      exec-once = [
        "waybar &"
        "swww-daemon"
        "swww img ~/wallpapers/wallpaper3.jpg --transition-type fade"
        "ydotoold &"

      ];
      
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
      ];
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(aa77ddff) rgba(ff00ffff) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      
      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        
        blur = {
          enabled = true;
          size = 10;
          passes = 1;
          vibrancy = 0.1696;
        };
      };
      
      animations = {
        enabled = true;
        
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        
        animation = [
          "global,1,10,default"
          "border,1,5.39,easeOutQuint"
          "windows,1,4.79,easeOutQuint"
          "windowsIn,1,4.1,easeOutQuint,popin 87%"
          "windowsOut,1,1.49,linear,popin 87%"
          "fadeIn,1,1.73,almostLinear"
          "fadeOut,1,1.46,almostLinear"
          "fade,1,3.03,quick"
          "layers,1,3.81,easeOutQuint"
          "layersIn,1,4,easeOutQuint,fade"
          "layersOut,1,1.5,linear,fade"
          "fadeLayersIn,1,1.79,almostLinear"
          "fadeLayersOut,1,1.39,almostLinear"
          "workspaces,1,1.94,almostLinear,fade"
          "workspacesIn,1,1.21,almostLinear,fade"
          "workspacesOut,1,1.94,almostLinear,fade"
        ];
      };
      
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      
      master = {
        new_status = "master";
      };
      
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };
      
      input = {
        kb_layout = "pl";
        kb_variant = "";
        kb_model = "";
        kb_options = "ctrl:nocaps";
        kb_rules = "";
        left_handed = false;
        follow_mouse = 1;
        sensitivity = 0;
        
        touchpad = {
          natural_scroll = false;
        };
      };
      
      gestures = {
        workspace_swipe = false;
      };
      
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };
      
      workspace = [
        "1,monitor:eDP-1,default:true"
        "2,monitor:HDMI-A-1,default:true"
        "3,monitor:HDMI-A-1"
        "4,monitor:HDMI-A-1"
        "5,monitor:HDMI-A-1"
        "6,monitor:HDMI-A-1"
        "7,monitor:HDMI-A-1"
        "8,monitor:HDMI-A-1"
        "9,monitor:HDMI-A-1"
      ];
      
      windowrule = [
        "suppressevent maximize,class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
      
      bind = [
        "SUPER SHIFT,P,exec,pkill waybar && waybar &"
        #reload tapety
        "$mainMod CTRL SHIFT,R,exec,pkill swww && swww-daemon && sleep 0.5 && swww img ~/wallpapers/wallpaper3.jpg"
        "$mainMod,F,fullscreen,0"
        
        "$mainMod,return,exec,$terminal"
        "$mainMod,Q,killactive,"
        "$mainMod,M,exit,"
        "$mainMod,E,exec,$fileManager"
        "$mainMod,V,togglefloating,"
        "$mainMod,D,exec,$menu"
        "$mainMod,P,pseudo,"
        "$mainMod,I,togglesplit,"
        
        "$mainMod,H,movefocus,l"
        "$mainMod,L,movefocus,r"
        "$mainMod,K,movefocus,u"
        "$mainMod,J,movefocus,d"
        
        
        "$mainMod,1,workspace,1"
        "$mainMod,2,workspace,2"
        "$mainMod,3,workspace,3"
        "$mainMod,4,workspace,4"
        "$mainMod,5,workspace,5"
        "$mainMod,6,workspace,6"
        "$mainMod,7,workspace,7"
        "$mainMod,8,workspace,8"
        "$mainMod,9,workspace,9"
        "$mainMod,0,workspace,10"
        
        "$mainMod SHIFT,1,movetoworkspace,1"
        "$mainMod SHIFT,2,movetoworkspace,2"
        "$mainMod SHIFT,3,movetoworkspace,3"
        "$mainMod SHIFT,4,movetoworkspace,4"
        "$mainMod SHIFT,5,movetoworkspace,5"
        "$mainMod SHIFT,6,movetoworkspace,6"
        "$mainMod SHIFT,7,movetoworkspace,7"
        "$mainMod SHIFT,8,movetoworkspace,8"
        "$mainMod SHIFT,9,movetoworkspace,9"
        "$mainMod SHIFT,0,movetoworkspace,10"
        
        "$mainMod,S,togglespecialworkspace,magic"
        "$mainMod SHIFT,S,movetoworkspace,special:magic"
        
        "$mainMod,mouse_down,workspace,e+1"
        "$mainMod,mouse_up,workspace,e-1"
        
        ",Print,exec,grim ~/Pictures/$(date +%Y%m%d_%H%M%S).png"
        "SHIFT,Print,exec,grim -g \"$(slurp)\" ~/Pictures/$(date +%Y%m%d_%H%M%S).png"
        "CTRL,Print,exec,grim - | wl-copy"
        "CTRL SHIFT,Print,exec,grim -g \"$(slurp)\" - | wl-copy"


      ];
      
      bindm = [
        "$mainMod,mouse:272,movewindow"
        "$mainMod,mouse:273,resizewindow"
      ];
      
      bindel = [
        ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp,exec,brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown,exec,brightnessctl -e4 -n2 set 5%-"
      ];
      
      bindl = [
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPause,exec,playerctl play-pause"
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPrev,exec,playerctl previous"
      ];
    };
  };
  
}
