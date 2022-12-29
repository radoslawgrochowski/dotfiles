{ lib, config, pkgs, inputs, ... }:
let 
  # source https://github.com/folke/tokyonight.nvim/blob/main/extras/fish/tokyonight_night.fish
  tokyoNight = ''
	set -l foreground c0caf5
	set -l selection 33467c
	set -l comment 565f89
	set -l red f7768e
	set -l orange ff9e64
	set -l yellow e0af68
	set -l green 9ece6a
	set -l purple 9d7cd8
	set -l cyan 7dcfff
	set -l pink bb9af7

	# Syntax Highlighting Colors
	set -g fish_color_normal $foreground
	set -g fish_color_command $cyan
	set -g fish_color_keyword $pink
	set -g fish_color_quote $yellow
	set -g fish_color_redirection $foreground
	set -g fish_color_end $orange
	set -g fish_color_error $red
	set -g fish_color_param $purple
	set -g fish_color_comment $comment
	set -g fish_color_selection --background=$selection
	set -g fish_color_search_match --background=$selection
	set -g fish_color_operator $green
	set -g fish_color_escape $pink
	set -g fish_color_autosuggestion $comment
  '';
in
{
  programs.fish = {
    enable = true;
    plugins = [
      # { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
      { name = "done"; src = pkgs.fishPlugins.done.src; }
    ];
    interactiveShellInit = ''
        set -g fish_key_bindings fish_vi_key_bindings 
        set fish_greeting ""

	${tokyoNight}
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      palette = "tokyonight";
      palettes.tokyonight = {
	 foreground = "#c0caf5";
	 selection = "#33467c";
	 comment = "#565f89";
	 red = "#f7768e";
	 orange = "#ff9e64";
	 yellow = "#e0af68";
	 green = "#9ece6a";
	 purple = "#9d7cd8";
	 cyan = "#7dcfff";
	 pink = "#bb9af7";
      };

	aws.symbol = "  ";
	buf.symbol = " ";
	c.symbol = " ";
	conda.symbol = " ";
	dart.symbol = " ";
	directory.read_only = " ";
	docker_context.symbol = " ";
	elixir.symbol = " ";
	elm.symbol = " ";
	git_branch.symbol = " ";
	golang.symbol = " ";
	guix_shell.symbol = " ";
	haskell.symbol = " ";
	haxe.symbol = "⌘ ";
	hg_branch.symbol = " ";
	java.symbol = " ";
	julia.symbol = " ";
	lua.symbol = " ";
	memory_usage.symbol = " ";
	meson.symbol = "喝 ";
	nim.symbol = " ";
	nix_shell.symbol = " ";
	nodejs.symbol = " ";
	os.symbols.NixOS = " ";
	package.symbol = " ";
	python.symbol = " ";
	rlang.symbol = "ﳒ ";
	ruby.symbol = " ";
	rust.symbol = " ";
	scala.symbol = " ";
	spack.symbol = "🅢 ";

    };
  };
}
