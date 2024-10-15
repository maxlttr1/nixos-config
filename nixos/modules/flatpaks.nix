{
   # Enable flatpak
  services.flatpak = {
    enable = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };

  services.flatpak.remotes = [{
    name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
  }];

}
