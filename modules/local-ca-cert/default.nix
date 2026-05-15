# Append a locally managed corporate CA to the system bundle when present.
{ pkgs, ... }:
let
  baseBundle = "/etc/ssl/certs/ca-certificates.crt";
  localCertDir = "/etc/ssl/local/certificates.d";
  combinedBundle = "/etc/ssl/certs/ca-certificates-local.crt";
in
{
  security.pki.installCACerts = true;

  system.activationScripts.localCaBundle.text = ''
    set -euo pipefail

    ${pkgs.coreutils}/bin/install -d -m 0755 /etc/ssl/certs

    tmp_bundle="$(${pkgs.coreutils}/bin/mktemp "${combinedBundle}.XXXXXX")"
    ${pkgs.coreutils}/bin/cp "${baseBundle}" "$tmp_bundle"

    if [ -d "${localCertDir}" ]; then
      for cert in "${localCertDir}"/*; do
        if [ -f "$cert" ] && [ -s "$cert" ]; then
          printf '\n' >> "$tmp_bundle"
          ${pkgs.coreutils}/bin/cat "$cert" >> "$tmp_bundle"
        fi
      done
    fi

    ${pkgs.coreutils}/bin/chmod 0644 "$tmp_bundle"
    ${pkgs.coreutils}/bin/mv "$tmp_bundle" "${combinedBundle}"
  '';

  nix.settings.ssl-cert-file = combinedBundle;
  environment.variables = {
    NODE_EXTRA_CA_CERTS = combinedBundle;
    SSL_CERT_FILE = combinedBundle;
  };
}
