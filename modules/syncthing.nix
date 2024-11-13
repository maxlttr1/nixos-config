{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    /*settings.gui = {
      user = "maxlttr";
      password = "passwd";
    };k*/
  };

  /*networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];*/
}