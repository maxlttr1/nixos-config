{ config, ... }:

{
  services.ssh-agent = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  home.file."/home/${config.users.mainUsername}/.ssh/config".text = ''
    Host asus-maxlttr
        HostName asus-maxlttr
        User maxlttr
        IdentityFile /home/${config.users.mainUsername}/.config/sops-nix/secrets/nixos_ssh_setup.private
    Host server-maxlttr
        HostName server-maxlttr
        User maxlttr
        IdentityFile /home/${config.users.mainUsername}/.config/sops-nix/secrets/nixos_ssh_setup.private
    Host fly2clean
        HostName videocompress.polytech.univ-nantes.prive
        User ptrans_fly2clean_2025
        IdentityFile /home/${config.users.mainUsername}/.ssh/fly2clean
  '';
}
