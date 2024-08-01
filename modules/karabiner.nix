{ username, pkgs, ... }:
let
  terminalSwap = from: to: {
    type = "basic";
    from = {
      key_code = from;
      modifiers = { optional = [ "any" ]; };
    };
    to = [{ key_code = to; }];
    conditions = [{
      type = "frontmost_application_unless";
      bundle_identifiers = [
        "^com\\.apple\\.Terminal$"
        "^net\\.kovidgoyal\\.kitty$"
      ];
      file_paths = [ "\\.kitty-wrapped$" ];
    }];
  };

  disable = key: modifiers: {
    type = "basic";
    from = {
      key_code = key;
      modifiers = { mandatory = modifiers; };
    };
    to = [{ key_code = "vk_none"; }];
  };

in
{
  services.karabiner-elements.enable = true;
  home-manager.users.${username} = {
    home.packages = [ pkgs.unstable.karabiner-elements ];

    # Karabiner Elements still need to be set up manually 
    # this just adds local presets
    home.file.karabiner-control = {
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
    home.file.karabiner-huddle = {
      target = ".config/karabiner/assets/complex_modifications/slack.json";
      text = builtins.toJSON {
        title = "my slack rules";
        rules = [
          {
            description = "Disable Command + Shift + H (Slack Huddle)";
            manipulators = [
              (disable "h" [ "left_command" "left_shift" ])
            ];
          }
        ];
      };
    };
  };
}
