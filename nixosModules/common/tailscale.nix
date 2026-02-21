{ lib, config, pkgs, ... }:

{
  options = {
    custom.tailscale.enable = lib.mkEnableOption "Enable Tailscale VPN";
  };

  config = lib.mkIf config.custom.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both"; #Enables settings required for Tailscale's routing features like subnet routers and exit nodes. To use these these features, you will still need to call sudo tailscale up with the relevant flags like --advertise-exit-node and --exit-node. When set to client or both, reverse path filtering will be set to loose instead of strict. When set to server or both, IP forwarding will be enabled. One of "none", "client", "server", "both"
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
