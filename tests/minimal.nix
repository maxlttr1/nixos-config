{
  pkgs,
  modules,
  ...
}:

pkgs.testers.runNixOSTest {
  name = "minimal-test";
  nodes = {
    machine = { config, pkgs, ... }: {
      imports = modules;
      config = { };
    };
  };
  testScript = ''
    machine.start()
    machine.wait_for_unit("multi-user.target")
    # machine.wait_for_unit("sshd.service")

    machine.succeed("findmnt /")
    machine.succeed("mount")
    machine.succeed("stat /")

    machine.succeed("systemctl is-active NetworkManager.service")
    machine.succeed("nmcli general status")
    machine.succeed("nmcli device status")
    machine.succeed("systemctl is-active systemd-resolved.service")
    machine.succeed("cat /etc/resolv.conf")
    machine.succeed("resolvectl status")
    machine.succeed("resolvectl dns")
    machine.succeed("resolvectl domain")
    # machine.succeed("resolvectl query google.com")
    machine.succeed("ip addr")
    machine.succeed("ip route")
    machine.succeed("ping -c 3 127.0.0.1")
    # machine.succeed("ping -c 3 google.com")

    machine.fail("systemctl --failed --no-legend | grep .")

    machine.succeed("systemctl is-active docker.service")
    machine.succeed("docker info")
    machine.succeed("docker ps")
    # machine.succeed("docker run --rm hello-world")

    machine.succeed("systemctl is-active tailscaled.service")
    # machine.succeed("tailscale version")

    machine.succeed("systemctl is-active syncthing.service")
    machine.succeed("ss -ltn | grep ':8384'")
    machine.wait_until_succeeds("curl -fs http://127.0.0.1:8384/ >/dev/null")

    # machine.succeed("systemctl is-active sshd.service")
    machine.succeed("ss -ltn | grep ':22'")

    # machine.execute("firefox &")
    # machine.succeed("pgrep firefox")

    # machine.succeed("which flatpak")
    # machine.succeed("flatpak --version")
    # machine.execute("flatpak list")
    # machine.succeed("systemctl is-active flatpak-system-helper.service")

    machine.execute("fish -c 'echo hello world'")
  '';
}
