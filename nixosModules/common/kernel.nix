{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    custom.kernel = lib.mkOption {
      description = "Enable kernel hardening and configuration";
      default = "linuxPackages";
      type = lib.types.enum [
        "linuxPackages"
        "linuxPackages_latest"
        "linuxPackages_hardened"
      ];
    };
  };

  config = {
    boot.kernelPackages = pkgs."${config.custom.kernel}";

    boot.blacklistedKernelModules = [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"

      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];

    # Kernel sysctl settings (runtime parameters - can be changed without reboot)
    boot.kernel.sysctl = {
      ###################################
      ### KERNEL SECURITY & DEBUGGING ###
      ###################################
      # Prevent coredumps from SUID programs (blocks info leaks from privileged processes)
      "fs.suid_dumpable" = 0;
      # Disable core dump handling
      "kernel.core_pattern" = "|/bin/false";
      # Include process ID in coredump filename (prevents predictable filename exploits)
      "kernel.core_uses_pid" = 1;
      # Disable kexec - prevents loading a new kernel without reboot (security feature)
      "kernel.kexec_load_disabled" = 1;
      # Hide kernel pointers from unprivileged users (mitigates info disclosure attacks)
      "kernel.kptr_restrict" = 2;
      # Users must have CAP_SYSLOG to use dmesg
      "kernel.dmesg_restrict" = 1;
      # Panic on kernel oops - crash system when kernel detects internal bugs
      "kernel.panic_on_oops" = 1;
      # Restrict performance event monitoring to root only (prevents side-channel attacks)
      "kernel.perf_event_paranoid" = 2;
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
      # Restrict userfaultfd to privileged processes only (mitigates kernel exploitation techniques and use-after-free flaws)
      "vm.unprivileged_userfaultfd" = 0;
      # Enable Address Space Layout Randomization (ASLR)
      "kernel.randomize_va_space" = 2;
      # Disable loading of kernel modules
      # "kernel.modules_disabled" = 1;

      ############################
      ### FILESYSTEM HARDENING ###
      ############################
      # Only permit symlinks to be followed when outside of a world-writable sticky directory
      "fs.protected_symlinks" = 1;
      # Blocks hardlinking files you don’t own
      "fs.protected_hardlinks" = 1;
      # Restricts FIFO creation in sticky dirs (2 = owner-only)
      "fs.protected_fifos" = 2;
      # Restricts regular file creation in sticky dirs (2 = owner-only)
      "fs.protected_regular" = 2;

      ##############################
      ### NETWORKING (IPv4/IPv6) ###
      ##############################
      # Enable SYN cookies (prevents SYN flood attacks)
      "net.ipv4.tcp_syncookies" = 1;
      # Protects against TIME-WAIT assassination (TCP timestamp attacks)
      "net.ipv4.tcp_rfc1337" = 1;
      # Enable source validation of packets received (prevents IP spoofing)
      # "net.ipv4.conf.default.rp_filter" = 1;
      # "net.ipv4.conf.all.rp_filter" = 1;
      # Disable ICMP redirects (prevents potential traffic redirection)
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      # Blocks packets trying to define their own route
      "net.ipv6.conf.all.accept_source_route" = 0;
      "net.ipv6.conf.default.accept_source_route" = 0;
      # Disable sending ICMP redirects (normal for routers but unnecessary for end hosts)
      "net.ipv4.conf.default.send_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv6.conf.all.send_redirects" = 0;
      "net.ipv6.conf.default.send_redirects" = 0;
      # Ignore all ICMP Echo Requests (Blocks ping requests, can mitigate some network scanning/reconnaissance)
      # "net.ipv4.icmp_echo_ignore_all" = 1;
      # Prevent bogus ICMP errors from filling up logs.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    };

    # Kernel boot parameters (passed at boot time, cannot be changed without reboot)
    boot.kernelParams = [
      # Enable kernel lockdown in integrity mode - prevents unauthorized kernel modifications
      "lockdown=integrity"
      # Enforce signed kernel modules only - blocks loading of unsigned/malicious modules
      "module.sig_enforce=1"
      # Disables vsyscalls, they've been replaced with vDSO
      "vsyscall=none"
      # Enables randomization in the kernel’s page allocator
      "page_alloc.shuffle=1"
      # Enables zeroing of memory during allocation and free time (helps mitigate use-after-free vulnerabilaties)
      "init_on_alloc=1"
      "init_on_free=1"
      # Makes it harder to influence slab cache layout
      "slab_nomerge"
    ];

    security = {
      # Forbids setting "user.max_user_namespaces" = 0 in sysctl
      allowUserNamespaces = true;
    };
  };
}
