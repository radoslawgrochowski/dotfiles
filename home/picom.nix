{ config, pkgs, inputs, ... }:

{
  services.picom = {
    enable = true;
    shadow = true;
    backend = "glx";
    settings = {
        fading = true;
	fade-in-step = 0.03;
	fade-out-step = 0.03;
        fade-delta = 5;

	blur = {
        	method = "dual_kawase";
		strength = 7;
	};

	blur-background-exclude = [
	  "window_type = 'dock'"
	  "window_type = 'desktop'"
	  "_GTK_FRAME_EXTENTS@:c"
	];
inactive-opacity = 1;
frame-opacity = 0.5;
opacity-rule = [
  "88:class_g = 'kitty' && focused"
  "80:class_g = 'kitty' && !focused"
  "80:class_g = 'Spotify'"
];


        corner-radius = 10;
	rounded-corners-exclude = [
	  "window_type = 'dock'"
	  "window_type = 'desktop'"
	];

    };
  };
}
