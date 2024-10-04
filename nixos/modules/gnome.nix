{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gnome.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
