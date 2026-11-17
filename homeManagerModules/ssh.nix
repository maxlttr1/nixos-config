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
        IdentityFile ${config.sops.secrets."ssh/nixos-setup/private".path}
      Host forgejo.maxlttr.fr
        HostName nexus-nexus
        User git
        Port 222
        IdentityFile ${config.sops.secrets."ssh/forgejo/private".path}
        IdentitiesOnly yes
    '';
  };
}
