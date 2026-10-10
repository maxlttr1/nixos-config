{ config, pkgs, ... }:

''
  payload=$(${pkgs.jq}/bin/jq -n --arg msg "$msg" '{content: $msg}' || echo '{}')
  ${pkgs.curl}/bin/curl -X POST "$(cat ${
    config.sops.secrets."discord-webhook".path
  })" -H "Content-Type: application/json" -d "$payload"

  payload=$(${pkgs.jq}/bin/jq -n --arg msg "$msg" '(
    {
      message: $msg,
      title: "",
      priority: 5,
      extras: {"client::display": {contentType: "text/markdown"}}
    }
  )' || echo '{}')
  ${pkgs.curl}/bin/curl -fsS -X POST "https://gotify.maxlttr.fr/message" -H 'Content-Type: application/json' -H "X-Gotify-Key: $(cat ${
    config.sops.secrets."gotify.nixos-upgrade".path
  })" -d "$payload"
''
