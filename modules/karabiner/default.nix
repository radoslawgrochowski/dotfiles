{ username, pkgs, ... }:
let
  terminalSwap = from: to: {
    type = "basic";
    from = {
      key_code = from;
      modifiers = {
        optional = [ "any" ];
      };
    };
    to = [ { key_code = to; } ];
    conditions = [
      {
        type = "frontmost_application_unless";
        bundle_identifiers = [
          "^com\\.apple\\.Terminal$"
          "^net\\.kovidgoyal\\.kitty$"
        ];
        file_paths = [ "\\.kitty-wrapped$" ];
      }
    ];
  };

  disable = key: modifiers: {
    type = "basic";
    from = {
      key_code = key;
      modifiers = {
        mandatory = modifiers;
      };
    };
    to = [ { key_code = "vk_none"; } ];
  };

in
{
  # FIXME: https://github.com/nix-darwin/nix-darwin/pull/1679
  # services.karabiner-elements = {
  #   enable = true;
  # };

  home-manager.users.${username} = {
    # Karabiner Elements still need to be set up manually
    # this just adds local presets
    home.file.karabiner-terminal = {
      target = ".config/karabiner/assets/complex_modifications/terminal.json";
      text = builtins.toJSON {
        title = "my terminal rules";
        rules = [
          {
            description = "Swap Left Command and Left Control unless in Terminal";
            manipulators = [
              (terminalSwap "left_command" "left_control")
              (terminalSwap "left_control" "left_command")
            ];
          }
        ];
      };
    };
    home.file.karabiner-slack = {
      target = ".config/karabiner/assets/complex_modifications/slack.json";
      text = builtins.toJSON {
        title = "my slack rules";
        rules = [
          {
            description = "Disable Command + Shift + H (Slack Huddle)";
            manipulators = [
              (disable "h" [
                "left_command"
                "left_shift"
              ])
            ];
          }
        ];
      };
    };
    home.file.karabiner-darwin = {
      target = ".config/karabiner/assets/complex_modifications/dariwn.json";
      text = builtins.toJSON {
        title = "my chrome rules";
        rules = [
          {
            description = "Disable Command + Shift + I (Email current page)";
            manipulators = [
              (disable "i" [
                "left_command"
                "left_shift"
              ])
            ];
          }
        ];
      };
    };
  };
}
