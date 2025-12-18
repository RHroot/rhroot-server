{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;

    virtualHosts."rishabhhaldiya.me" = {
      forceSSL = true;
      sslCertificate = "/etc/ssl/cloudflare/cert.pem";
      sslCertificateKey = "/etc/ssl/cloudflare/key.pem";
      root = "/var/www/rishabhhaldiya.me";
    };

    virtualHosts."www.rishabhhaldiya.me" = {
      forceSSL = true;
      sslCertificate = "/etc/ssl/cloudflare/cert.pem";
      sslCertificateKey = "/etc/ssl/cloudflare/key.pem";
      root = "/var/www/rishabhhaldiya.me";
    };
  };
}
