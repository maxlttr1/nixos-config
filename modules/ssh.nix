{ config, pkgs, settings, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    allowSFTP = true;
    startWhenNeeded = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "${settings.username}" "root" ]; # Allows all users by default
      PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };


  #security.pam.services.sshd.googleAuthenticator.enable = true;

  users.users = {
    ${settings.username}.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeY9wKqfVwd5r7WXw3yVG//dAPkgLg9UIQ1U/hb/THoT5usKOACOx65YuFQiUaIeVwwQAby6lRU6MFdq+S6mL26lyRIrQMKLPXLGb0ww4s6GAwexKIm+vGEHDlRh+o2HZEBldUv5ZOqhoAj1y3zNwrkvHYqQJWrL3H+AIZ4p6JeQtCLaheDLoxiozHqGotB6Lb/H1Ao74XpKt9RWbRblB23GWYPURa8u+ULtKe2i5Cx7ae0LcsrEixEjbQIsv0SbGGE6/Ov+nmneOBo77wXtkaGLEnf6Xqacumi5iFM3Yv/+l0ag/V10fvOmsH00KusSDwZ/KvdCAXUwmHG14H598W2apaWGjqCkhLePt+HvdIuZ/ENlpQ0vdXBem8VObW88N7qytvEeR7HEvpKebat4E8Inaw+caoozvSfOLx9xw5rOY2gCDIZmC+B/M9jJQNu+wMabd0yndQM6P+4l4TxQn3/ubD6oYSP0r5qWEAxMIdFdG59E81OLsZVyCrh9lNE48= maxlttr@asus-maxlttr"
    ];
    root.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeY9wKqfVwd5r7WXw3yVG//dAPkgLg9UIQ1U/hb/THoT5usKOACOx65YuFQiUaIeVwwQAby6lRU6MFdq+S6mL26lyRIrQMKLPXLGb0ww4s6GAwexKIm+vGEHDlRh+o2HZEBldUv5ZOqhoAj1y3zNwrkvHYqQJWrL3H+AIZ4p6JeQtCLaheDLoxiozHqGotB6Lb/H1Ao74XpKt9RWbRblB23GWYPURa8u+ULtKe2i5Cx7ae0LcsrEixEjbQIsv0SbGGE6/Ov+nmneOBo77wXtkaGLEnf6Xqacumi5iFM3Yv/+l0ag/V10fvOmsH00KusSDwZ/KvdCAXUwmHG14H598W2apaWGjqCkhLePt+HvdIuZ/ENlpQ0vdXBem8VObW88N7qytvEeR7HEvpKebat4E8Inaw+caoozvSfOLx9xw5rOY2gCDIZmC+B/M9jJQNu+wMabd0yndQM6P+4l4TxQn3/ubD6oYSP0r5qWEAxMIdFdG59E81OLsZVyCrh9lNE48= maxlttr@asus-maxlttr"
    ];
  };
}
