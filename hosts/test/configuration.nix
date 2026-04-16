{ lib, settings, ... }:

{
  custom.hostname = "test";

  custom.impermanence.enable = true;

  custom.usbguard.enable = lib.mkForce false;
}
