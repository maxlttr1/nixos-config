{
  security.auditd.enable = true;
  security.audit.enable = true;

  security.audit.rules = [
    # Root program executions
    "-a exit,always -F arch=b64 -S execve -F uid=0"
    # File deletions and permission changes
    "-a exit,always -F arch=b64 -S unlink,chmod,chown -F uid=0"
    # Sensitive file access (/etc, /root)
    "-a exit,always -F arch=b64 -S open -F dir=/etc -F uid=0"
    "-a exit,always -F arch=b64 -S open -F dir=/root -F uid=0"
    # Privilege escalation via sudo/su
    "-a exit,always -F arch=b64 -S execve -F exe=/run/wrappers/bin/sudo"
    "-a exit,always -F arch=b64 -S execve -F exe=/run/wrappers/bin/su"
    # Network connections and port binding by root
    "-a exit,always -F arch=b64 -S connect -F uid=0"
    "-a exit,always -F arch=b64 -S bind -F uid=0"
  ];

  security.auditd.settings = {
    log_file = "/var/log/audit/audit.log";
    max_log_file = 512;  # Max 512 MB per file
    max_log_file_action = "rotate";  # Rotate when full
    num_logs = 1;  # Keep 1 file (512 MB total)
    space_left_action = "ignore";  # Don't alert, just delete
  };
}