{ lib, config, pkgs, settings, ... }:

{
  options = {
    kernel = lib.mkOption {
      description = "Enable kernel hardening and configuration";
      default = "linuxPackages";
      type = lib.types.enum [ "linuxPackages" "linuxPackages_latest" "linuxPackages_hardened" ];
    };
  };

  config = {
    boot.kernelPackages = pkgs."${config.kernel}";

    # Kernel sysctl settings (runtime parameters - can be changed without reboot)
    boot.kernel.sysctl = {
      # Prevent coredumps from SUID programs (blocks info leaks from privileged processes)
      "fs.suid_dumpable" = 0;
      # Include process ID in coredump filename (prevents predictable filename exploits)
      "kernel.core_uses_pid" = 1;
      # Disable kexec - prevents loading a new kernel without reboot (security feature)
      "kernel.kexec_load_disabled" = 1;
      # Hide kernel pointers from unprivileged users (mitigates info disclosure attacks)
      "kernel.kptr_restrict" = 2;
      # Panic on kernel oops - crash system when kernel detects internal bugs
      "kernel.panic_on_oops" = 1;
      # Restrict performance event monitoring to root only (prevents side-channel attacks)
      "kernel.perf_event_paranoid" = 3;
      # SysRq exposes a lot of potentially dangerous debugging functionality to unprivileged users
      # 4 makes it so a user can only use the secure attention key. A value of 0 would disable completely
      "kernel.sysrq" = 0;
      # Disable ptrace access - prevents process tracing (blocks debugging/process inspection)
      "kernel.yama.ptrace_scope" = 3;
      # Tells the kernel to ignore Ctrl+Alt+Del (reboot)
      "kernel.ctrl-alt-del" = 0;
      # Enable BPF JIT hardening - mitigates JIT spraying attacks on eBPF code
      "net.core.bpf_jit_harden" = 2;
      # Toggles whether or not unprivileged processes can create user namespaces	
      "kernel.unprivileged_userns_clone" = 1;
      # Only permit symlinks to be followed when outside of a world-writable sticky directory
      "fs.protected_symlinks" = 1;
      # Blocks hardlinking files you don’t own
      "fs.protected_hardlinks" = 1;
      # Restricts FIFO creation in sticky dirs (2 = owner-only)
      "fs.protected_fifos" = 2;
      # Restricts regular file creation in sticky dirs (2 = owner-only)
      "fs.protected_regular" = 2;
    };

    # Kernel boot parameters (passed at boot time, cannot be changed without reboot)
    boot.kernelParams = [
      # Enable kernel lockdown in integrity mode - prevents unauthorized kernel modifications
      "lockdown=integrity"
      # Enforce signed kernel modules only - blocks loading of unsigned/malicious modules
      "module.sig_enforce=1"
      # Disables vsyscalls, they've been replaced with vDSO
      "vsyscall=none"
    ];

    security = {
      # Forbids setting "user.max_user_namespaces" = 0 in sysctl
      allowUserNamespaces = true;
    };
  };
}
