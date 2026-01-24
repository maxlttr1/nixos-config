{ pkgs, settings, ... }:

{
  boot.kernelPackages = pkgs."${settings.kernel}";

  # Kernel sysctl settings (runtime parameters - can be changed without reboot)
  boot.kernel.sysctl = {
    /*# Prevent coredumps from SUID programs (blocks info leaks from privileged processes)
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
    # Disable ptrace access - prevents process tracing (blocks debugging/process inspection)
    "kernel.yama.ptrace_scope" = 3;
    # Enable BPF JIT hardening - mitigates JIT spraying attacks on eBPF code
    "net.core.bpf_jit_harden" = 2;*/
	"kernel.unprivileged_userns_clone" = 1;
  };

  /*
  boot.kernel.sysctl = {
  "fs.suid_dumpable" = 0;
  "kernel.core_uses_pid" = 1;
  "kernel.kexec_load_disabled" = 1;
  "kernel.kptr_restrict" = 2;
  "kernel.perf_event_paranoid" = 2;      # Relaxed for Electron
  "kernel.yama.ptrace_scope" = 2;        # Relaxed for Electron
  "net.core.bpf_jit_harden" = 2;
};
*/

  # Kernel boot parameters (passed at boot time, cannot be changed without reboot)
  /*boot.kernelParams = [
    # Enable kernel lockdown in integrity mode - prevents unauthorized kernel modifications
    "lockdown=integrity"
    # Enforce signed kernel modules only - blocks loading of unsigned/malicious modules
    "module.sig_enforce=1"
  ];*/

   # Kernel compilation patches (applied at build time)
  /*boot.kernelPatches = [
    {
      name = "hardened";
      patch = null;
      extraConfig = ''
      '';
    }
  ];*/
}