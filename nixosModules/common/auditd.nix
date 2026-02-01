{ lib, config, ... }:

{
  options = {
    auditd.enable = lib.mkEnableOption "Enable security audit daemon";
  };

  config = lib.mkIf config.auditd.enable {
    security.auditd.enable = true;
    security.audit.enable = true;

    security.audit.rules = [
      # Log all program executions on 64-bit architecture
      "-a exit,always -F arch=b64 -S execve"
    ];

    security.auditd.settings = {
      log_file = "/var/log/audit/audit.log";
      max_log_file = 100; # Max 100 MB per file
      max_log_file_action = "rotate"; # Rotate when full
      num_logs = 10; # Keep 10 rotated files (1 GB total)
      space_left_action = "rotate"; # rotate logs, losing the oldest to free up space
    };
  };
}
