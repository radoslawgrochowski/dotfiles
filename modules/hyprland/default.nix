{ username, pkgs, inputs, ... }:

{
  imports = [ inputs.hyprland.nixosModules.default ];

  nixpkgs.overlays = [
    (import ../../overlays/waybar.nix)
  ];

  hardware.opengl.enable = true;
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
  };
  programs.xwayland.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  users.groups.input.members = [ username ];

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      grim
      slurp
      swaybg
      swaylock
      wdisplays
      wireplumber
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      nvidiaPatches = true;
      extraConfig = ''
        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor=,preferred,auto,auto

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more

        # Execute your favorite apps at launch

        exec = /bin/sh ${./random-bg.sh}
        exec-once = /bin/sh ${./google-drive.sh}

        # Source a file (multi-file configs)
        # source = ~/.config/hypr/myColors.conf

        # Some default env vars.
        env = XCURSOR_SIZE,40

        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
        input {
            kb_layout = pl 
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =

            follow_mouse = 1

            touchpad {
                natural_scroll = true 
            }

            sensitivity = 0.2 # -1.0 - 1.0, 0 means no modification.
            force_no_accel = true
        }

        general {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            gaps_in = 5
            gaps_out = 5 
            border_size = 1
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)

            resize_on_border = true

            layout = master 
        }

        decoration {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            rounding = 6 
            blur = true
            blur_size = 8
            blur_passes = 1
            blur_new_optimizations = true

            drop_shadow = true
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
        }

        animations {
            enabled = true

            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = myBezier, 0.05, 0.9, 0.1, 1.05

            animation = windows, 1, 3, myBezier
            animation = windowsOut, 1, 3, default, popin 50%
            animation = windowsMove, 1, 3, default, slide
            animation = border, 1, 8, default
            animation = borderangle, 1, 7, default
            animation = fade, 1, 4, default
            animation = workspaces, 1, 3, default
        }

        dwindle {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # you probably want this
        }

        master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = false 
        }

        gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = true 
        }

        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
        # device:epic-mouse-v1 {
        #     sensitivity = -0.5
        # }

        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        windowrule = opacity 0.95 0.9, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        windowrulev2 = tile, class:^(Spotify)$

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER

        # See https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, Return, exec, kitty
        bind = $mainMod, D, exec, rofi -show combi 
        bind = $mainMod, Period, exec, rofi -show emoji 
        bind = $mainMod, Equal, exec, rofi -show calc
        bind = $mainMod, Q, killactive,
        bind = $mainMod, N, exec, kitty fish -C 'nvim ~/Projects/notes/'
        bind = $mainMod SHIFT, N, exec, kitty fish -C 'sh ${./note.sh}'
        bind = $mainMod, T, togglefloating,
        bind = $mainMod, F, fullscreen
        bind = $mainMod, P, exec, sh ${./screenshot.sh}
        bind = $mainMod, S, togglespecialworkspace,
        bind = $mainMod SHIFT, S, movetoworkspace, special

        # bind = $mainMod, P, pseudo, # dwindle
        # bind = $mainMod, S, togglesplit, # dwindle

        # contract a window by moving one of its side inward
        # "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
        # "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
        #
        # # screenshots
        # "super + p" =
        #   "path=\"$HOME/Pictures/$(date +%s).png\" && maim -s \"$path\" && xclip -selection clipboard -t image/png \"$path\"";

        # Move focus with mainMod + arrow keys
        bind = $mainMod, h, movefocus, l
        bind = $mainMod, l, movefocus, r
        bind = $mainMod, k, movefocus, u
        bind = $mainMod, j, movefocus, d

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        # Move windows with shift + direction
        bind = SUPER SHIFT, H, movewindow, l
        bind = SUPER SHIFT, L, movewindow, r
        bind = SUPER SHIFT, K, movewindow, u
        bind = SUPER SHIFT, J, movewindow, d
      '';
    };
  };
}
