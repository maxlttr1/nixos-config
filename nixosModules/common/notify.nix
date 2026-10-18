{ config, pkgs, ... }:

''
  if [ -f "${config.sops.secrets."discord/webhook".path}" ]; then
    payload=$(${pkgs.jq}/bin/jq -n --arg msg "$msg" '{content: $msg}' || echo '{}')
    ${pkgs.curl}/bin/curl -fsS -X POST "$(cat ${
      config.sops.secrets."discord/webhook".path
    })" -H "Content-Type: application/json" -d "$payload"
  fi

  if [ -f "${config.sops.secrets."gotify/nixos-upgrade".path}" ]; then
    payload=$(${pkgs.jq}/bin/jq -n --arg msg "$msg" '(
      {
        message: $msg,
        title: "",
        priority: 5,
        extras: {"client::display": {contentType: "text/markdown"}}
      }
    )' || echo '{}')
    ${pkgs.curl}/bin/curl -fsS -X POST "https://gotify.maxlttr.fr/message" -H 'Content-Type: application/json' -H "X-Gotify-Key: $(cat ${
      config.sops.secrets."gotify/nixos-upgrade".path
    })" -d "$payload"
  fi

  if [ -f "${config.sops.secrets."nextcloud/secret".path}" ]; then
    NC_URL="$(cat ${config.sops.secrets."nextcloud/url".path})"
    TOKEN="$(cat ${config.sops.secrets."nextcloud/conversations/Monitoring.token".path})"
    SECRET="$(cat ${config.sops.secrets."nextcloud/secret".path})"

    payload=$(${pkgs.jq}/bin/jq -n --arg msg "$msg" '{"message": $msg}' || echo '{}')

    RANDOM_HEADER=$(${pkgs.openssl}/bin/openssl rand -hex 32)
    MESSAGE_TO_SIGN="''${RANDOM_HEADER}''${msg}"
    SIGNATURE=$(echo -n "$MESSAGE_TO_SIGN" | ${pkgs.openssl}/bin/openssl dgst -sha256 -hmac "$SECRET" | cut -d' ' -f2)

    ${pkgs.curl}/bin/curl -fsS -X POST "''${NC_URL}/ocs/v2.php/apps/spreed/api/v1/bot/''${TOKEN}/message" \
      -H "Content-Type: application/json" \
      -H "Accept: application/json" \
      -H "OCS-APIRequest: true" \
      -H "X-Nextcloud-Talk-Bot-Random: ''${RANDOM_HEADER}" \
      -H "X-Nextcloud-Talk-Bot-Signature: ''${SIGNATURE}" \
      -d "$payload"
  fi
''
