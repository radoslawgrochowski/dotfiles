# replace CA certificate files with custom ones, 
# e.g. because of MITM security like zscaler
# ca_cert file needs to be provided manualy
{
  security.pki.certificateFiles = [ "/etc/nix/ca_cert.pem" ];
  nix.settings.ssl-cert-file = "/etc/nix/ca_cert.pem";
  environment.variables = {
    NODE_EXTRA_CA_CERTS = "/etc/nix/ca_cert.pem";
  };
}
