{
  # Enable CUPS to print documents.
  services = {
    printing.enable = true;
    /*Most printers manufactured after 2013 support the IPP Everywhere protocol, i.e. printing without installing drivers. This is notably the case of all WiFi printers marketed as Apple-compatible (list).
    To detect these printers, add the following to your system configuration*/
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
