{ config, pkgs, inputs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
        i3GapsSupport = true;
	iwSupport = true;
	githubSupport = true;
    };
    
    config = ../polybar/config.ini;
    script = ''
	MONITORS=$(${pkgs.xorg.xrandr}/bin/xrandr --query \
	         | ${pkgs.gnugrep}/bin/grep " connected" \
		 | ${pkgs.coreutils}/bin/cut -d" " -f1)
	for m in $MONITORS; do
	  MONITOR=$m polybar --reload example &
	done
    '';
  };
}