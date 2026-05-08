{
  config,
  lib,
  settings,
  ...
}:

{
  options.custom.ssh.enable = lib.mkEnableOption "SSH agent and configuration";

  config = lib.mkIf config.custom.ssh.enable {
    services.ssh-agent.enable = true;

    home.file.".ssh/config".text = ''
      Host nexus-nexus
          HostName nexus-nexus
          User ${settings.username}
          IdentityFile /home/${settings.username}/.config/sops-nix/secrets/nixos_ssh_setup.private
      Host fly2clean
          HostName videocompress.polytech.univ-nantes.prive
          User ptrans_fly2clean_2025
          IdentityFile /home/${settings.username}/.ssh/fly2clean
    '';
  };
}
