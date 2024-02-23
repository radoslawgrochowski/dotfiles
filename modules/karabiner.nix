{ username, pkgs, ... }:
let
  swap = from: to: {
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
in
{
  services.karabiner-elements.enable = true;
  home-manager.users.${username} = {
    home.packages = [ pkgs.unstable.karabiner-elements ];

    # Karabiner Elements need to be set up manually 
    # this just installs preset for the key swap
    home.file.karabiner = {
      target = ".config/karabiner/assets/complex_modifications/control-command.json";
      text = builtins.toJSON {
        title = "Control <-> Command";
        rules = [{
          description = "Swap Left Command and Left Control unless in Terminal";
          manipulators = [
            (swap "left_command" "left_control")
            (swap "left_control" "left_command")
          ];
        }];
      };
    };
  };
}
