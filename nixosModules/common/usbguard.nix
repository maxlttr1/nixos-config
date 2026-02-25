{ lib, config, ... }:

{
  options = {
    custom.usbguard.enable = lib.mkEnableOption "Enables USBGuard.";
  };

  config = lib.mkIf config.custom.usbguard.enable {
    services.usbguard = {
      enable = true;
      rules = if config.networking.hostName == "terra-terra" then ''
        allow id 1d6b:0002 serial "0000:00:0d.0" name "xHCI Host Controller" hash "d3YN7OD60Ggqc9hClW0/al6tlFEshidDnQKzZRRk410=" parent-hash "Y1kBdG1uWQr5CjULQs7uh2F6pHgFb6VDHcWLk83v+tE=" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 serial "0000:00:0d.0" name "xHCI Host Controller" hash "4Q3Ski/Lqi8RbTFr10zFlIpagY9AKVMszyzBQJVKE+c=" parent-hash "Y1kBdG1uWQr5CjULQs7uh2F6pHgFb6VDHcWLk83v+tE=" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0002 serial "0000:00:14.0" name "xHCI Host Controller" hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 serial "0000:00:14.0" name "xHCI Host Controller" hash "prM+Jby/bFHCn2lNjQdAMbgc6tse3xVx+hZwjOPHSdQ=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
        allow id 0bda:0129 serial "20100201396000000" name "USB2.0-CRW" hash "om34qyRbPxnt/bsdFrR3g2SWxDVsInxWWsiFkDIyEnY=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface ff:06:50 with-connect-type "not used"
        allow id 13d3:56a2 serial "0x0001" name "USB2.0 HD UVC WebCam" hash "2vT8LDTEiBMzinmHemqNX0BH9JK6iHTINU+EJCrfcTI=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" with-interface { 0e:01:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 0e:02:00 fe:01:01 } with-connect-type "hardwired"
        allow id 04f3:0c6c serial "" name "ELAN:ARM-M4" hash "Yj8wXnqsCmHLPfqmpZhlTt+sOs8w1f6Dk1VbSzggy/U=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" via-port "3-7" with-interface ff:00:00 with-connect-type "hardwired"
        allow id 8087:0026 serial "" name "" hash "Z5csNGxiUukPPZwSHPyUqpVCNagsfOSSNL2CfXhw4IY=" parent-hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" via-port "3-10" with-interface { e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 e0:01:01 } with-connect-type "hardwired"
      '' else if config.networking.hostName == "nexus-nexus" then ''
        allow id 1d6b:0002 serial "0000:00:14.0" name "xHCI Host Controller" hash "jEP/6WzviqdJ5VSeTUY8PatCNBKeaREvo2OqdplND/o=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
        allow id 1d6b:0003 serial "0000:00:14.0" name "xHCI Host Controller" hash "3Wo3XWDgen1hD5xM3PSNl3P98kLp1RUTgGQ5HSxtf8k=" parent-hash "rV9bfLq7c2eA4tYjVjwO4bxhm+y6GgZpl9J60L0fBkY=" with-interface 09:00:00 with-connect-type ""
      '' else ''
        reject
      '';
    };
  };
}