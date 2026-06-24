{
  inputs,
  outputs,
  ...
}:
let
  username = "radoslaw.grochowski";
in
(inputs.nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    ({
      nixpkgs.overlays = (inputs.nixpkgs.lib.attrValues outputs.overlays);
    })
    (
      { pkgs, ... }:
      {
        imports = [
          inputs.nix-index-database.darwinModules.nix-index
          inputs.home-manager.darwinModules.home-manager
          ../../modules/fonts
          ../../modules/nix
          ../../modules/home-manager
          ../../modules/aerospace
          ../../modules/karabiner
          ../../modules/claude
          ../../modules/docker
          ../../modules/locale
          ../../modules/direnv
          ../../modules/fish
          ../../modules/git
          ../../modules/jujutsu
          ../../modules/kitty
          ../../modules/nvim
          ../../modules/opencode
          ../../modules/unfree
          ../../modules/zk
          ../../modules/spotify
        ];

        users.users."${username}" = {
          uid = 502;
          name = username;
          home = "/Users/${username}/";
          packages = with pkgs; [
            btop
            gh
            jc
            jq
            nix-search-cli
            ranger
            ripgrep
            tldr
            jira-cli-go
            pkgs.master.worktrunk
          ];
        };

        programs.nix-index.enable = true;
        programs.nix-index-database.comma.enable = true;
        programs.bash.enable = true;
        programs.zsh.enable = true;
        environment.shells = with pkgs; [
          bashInteractive
          zsh
        ];
        security.pam.services.sudo_local.touchIdAuth = true;
        system.primaryUser = username;
        system.configurationRevision = outputs.rev or outputs.dirtyRev or null;
        system.defaults = {
          menuExtraClock = {
            Show24Hour = true;
            ShowSeconds = false;
            ShowAMPM = false;
          };
          dock = {
            autohide = true;
            autohide-delay = 0.0;
          };
          NSGlobalDomain = {
            "com.apple.swipescrolldirection" = false;
            AppleMeasurementUnits = "Centimeters";
            AppleMetricUnits = 1;
            ApplePressAndHoldEnabled = false;
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            AppleTemperatureUnit = "Celsius";
            NSAutomaticWindowAnimationsEnabled = false;
            NSWindowResizeTime = 0.001;
          };
        };
      }
    )
    {
      nixpkgs.hostPlatform = "aarch64-darwin";
      nix.settings.system = "aarch64-darwin";
      nix.settings.extra-platforms = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      ids.gids.nixbld = 350;
      system.stateVersion = 4;
    }
  ];

  specialArgs = {
    inherit outputs inputs;
    inherit username;
  };
})
