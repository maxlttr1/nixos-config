{ lib, config, ... }:

{
  options = {
    samba.enable = lib.mkEnableOption "Enable Samba file sharing";
  };

  config = lib.mkIf config.samba.enable {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          /*"workgroup" = "WORKGROUP";
          "server string" = "smbnix";
          "netbios name" = "smbnix";
          "security" = "user";
          "hosts allow" = "192.168.0. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          #"map to guest" = "bad user";
          "invalid users" = [ "root" ];*/
        };
        "share" = {
          "path" = "/home/${config.users.mainUsername}/Samba";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "${config.users.mainUsername}";
          "force group" = "users";
        };
      };
    };

    # samba-wsdd service is used to advertise the shares to Windows hosts 
    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
