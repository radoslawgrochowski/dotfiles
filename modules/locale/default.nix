{ lib, options, ... }:
{
  config = {
    time.timeZone = "Europe/Warsaw";
  }
  // lib.optionalAttrs (builtins.hasAttr "i18n" options) {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "pl_PL.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_ADDRESS = "pl_PL.UTF-8";
        LC_IDENTIFICATION = "pl_PL.UTF-8";
        LC_MEASUREMENT = "pl_PL.UTF-8";
        LC_MONETARY = "pl_PL.UTF-8";
        LC_NAME = "pl_PL.UTF-8";
        # LC_NUMERIC = "pl_PL.UTF-8";
        LC_PAPER = "pl_PL.UTF-8";
        LC_TELEPHONE = "pl_PL.UTF-8";
        # LC_TIME = "pl_PL.UTF-8";
      };
    };
  };
}
