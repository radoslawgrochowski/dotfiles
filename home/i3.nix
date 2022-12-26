{ config, lib, pkgs, inputs, ... }:

let 
  mod = "Mod4";
  rightOutput = "DP-2 DP-1 DP-1-1 DP-1-2";
  centerOutput = "eDP-1";
  leftOutput = "HDMI-2 HDMI-1 HDMI-0";
in {
  home.packages = with pkgs; [
    xcwd
    kitty
    google-chrome
    i3lock
    feh
  ];
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = {
      terminal = "kitty";
      modifier = mod;
      gaps = {
	inner = 8;
	outer = 0;
        smartBorders = "on";
        smartGaps = true;  
      };
      keybindings = lib.mkOptionDefault {
        # Focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+c" = "exec google-chrome-stable https://google.com --new-window";
        "${mod}+Return" = "exec kitty -d `xcwd`";
        "${mod}+Shift+Return" = "exec kitty";
        "${mod}+n" = "exec kitty fish -c 'nvim ~/Projects/notes'";
        "${mod}+t" = "exec kitty fish -c 'nvim ~/Projects/notes/TODO.md'";
        "${mod}+Shift+n" = "exec kitty fish -c 'sh ~/scripts/note.sh'";
        "${mod}+period" = "exec rofi -show emoji";
        "${mod}+equal" = "exec rofi -show calc";
        "${mod}+m" = "exec i3lock -c 000000";
        "${mod}+p" = "exec shutter -s";
        "${mod}+Shift+p" = "exec shutter -a";
        "${mod}+Tab" = "workspace next";
       };

       menu = "rofi -show combi";

       floating = {
         modifier = mod;
       };

       modes.resize = {
	    Escape = "mode default";
	    Return = "mode default";
	    h = "resize shrink width 10 px or 10 ppt";
	    j = "resize grow height 10 px or 10 ppt";
	    k = "resize shrink height 10 px or 10 ppt";
	    l = "resize grow width 10 px or 10 ppt";
       };

       window.border = 4;

       assigns =  {
	"4" = [{ class = "keepassxc"; }];
	"5: 📨" = [{ class = "Microsoft Teams"; }];
	"6: 🎷" = [
		{ class = "Pavucontrol"; }
		{ class = "Spotify"; }
	];
       };

       window.commands = [
	  {
	    command = "move to workspace 6: 🎷";
	    criteria = { class = "Spotify"; };
	  }
	  {
	    command = "move to workspace 6: 🎷";
	    criteria = { class = "Pavucontrol"; };
	  }
	  {
	    command = "move to workspace 5: 📨";
	    criteria = { class = "Microsoft Teams"; };
	  }
	  {
	    command = "move to workspace 4";
	    criteria = { class = "keepassxc"; };
	  }
	];    


      workspaceOutputAssign = [
        { output= "${leftOutput} ${rightOutput} ${centerOutput}"; workspace= "1"; }
        { output= "${leftOutput} ${rightOutput} ${centerOutput}"; workspace= "2"; }
        { output= "${leftOutput} ${rightOutput} ${centerOutput}"; workspace= "3"; }
        { output= "${leftOutput} ${rightOutput} ${centerOutput}"; workspace= "4"; }

        { output= "${centerOutput} ${leftOutput} ${rightOutput}"; workspace= "5: 📨"; }
        { output= "${centerOutput} ${rightOutput} ${leftOutput}"; workspace= "6: 🎷"; }

        { output= "${rightOutput} ${centerOutput} ${leftOutput}"; workspace= "7"; }
        { output= "${rightOutput} ${centerOutput} ${leftOutput}"; workspace= "8"; }
        { output= "${rightOutput} ${centerOutput} ${leftOutput}"; workspace= "9"; }
        { output= "${rightOutput} ${centerOutput} ${leftOutput}"; workspace= "0"; }
      ];

      startup = [
        { command = "feh --randomize --bg-scale ~/Pictures/Wallpapers/*"; always = true; }
      ];
    };
    extraConfig = ''
    '';
  };
  
}

