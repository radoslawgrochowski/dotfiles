{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    xcwd
  ];

  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "kitty -d `xcwd`";
      "super + shift + Return" = "kitty";
      "super + d" = "rofi -show combi";
      "super + period" = "rofi -show emoji";
      "super + Escape" = "pkill -USR1 -x sxhkd";
      "super + alt + {q,r}" = "bspc {quit,wm -r}";
      "super + {_,shift + }q" = "bspc node -{c,k}";

      # open notes project
      "super + n" = "kitty fish -C 'nvim ~/Projects/notes/'";
      "super + shift + n" = "kitty fish -C 'sh ~/scripts/note.sh'";

      # alternate between the tiled and monocle layout
      "super + m" = "bsp-layout next --layouts tiled,monocle,tall";

      # swap the current node and the biggest window
      "super + g" = "bspc node -s biggest.window";
      # ??
      # send the newest marked node to the newest preselected node
      "super + y" = "bspc node newest.marked.local -n newest.!automatic.local";

      ## STATE/FLAGS
      # set the window state
      "super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

      # set the node flags
      "super + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";

      ## FOCUS/SWAP
      # [ bracketleft
      # { braceleft 
      # ( parenleft

      # focus the node in the given direction
      "super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";

      # focus the node for the given path jump
      "super + {p,b,comma,minus}" = "bspc node -f @{parent,brother,first,second}";

      # focus the next/previous window in the current desktop
      "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";

      # focus the next/previous desktop in the current monitor
      "super + paren{left,right}" = "bspc desktop -f {prev,next}.local";

      # focus the last node/desktop
      "super + {grave,Tab}" = "bspc {node,desktop} -f last";

      # focus the older or newer node in the focus history
      "super + {o,i}" = ''
        bspc wm -h off; \
        bspc node {older,newer} -f; \
        bspc wm -h on
      '';

      # focus or send to the given desktop
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

      ## PRESELECT
      # preselect the direction
      "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";

      # preselect the ratio
      "super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

      # cancel the preselection for the focused node
      "super + ctrl + space" = "bspc node -p cancel";

      # cancel the preselection for the focused desktop
      "super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

      # expand a window by moving one of its side outward
      "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

      # contract a window by moving one of its side inward
      "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";

      ## Desktop management
      "super + equal" = "bspc monitor -a \"$(rofi -dmenu -p Workspace -i -no-fixed-num-lines)\"";
      "super + minus" = "bspc desktop -r";
    };
  };
}
