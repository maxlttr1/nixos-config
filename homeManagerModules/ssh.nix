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
          IdentityFile ${config.sops.secrets."nixos_ssh_setup.private".path}
      Host fly2clean
          HostName videocompress.polytech.univ-nantes.prive
          User ptrans_fly2clean_2025
          IdentityFile ${config.sops.secrets."gitlab-univ-nantes.private".path}
    '';
  };
}
