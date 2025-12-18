{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;

    # Global Cloudflare IP handling
    appendHttpConfig = ''
      # Trust Cloudflare IPs and extract real client IP
      real_ip_header CF-Connecting-IP;

      # Cloudflare IPv4
      set_real_ip_from 173.245.48.0/20;
      set_real_ip_from 103.21.244.0/22;
      set_real_ip_from 103.22.200.0/22;
      set_real_ip_from 103.31.4.0/22;
      set_real_ip_from 141.101.64.0/18;
      set_real_ip_from 108.162.192.0/18;
      set_real_ip_from 190.93.240.0/20;
      set_real_ip_from 188.114.96.0/20;
      set_real_ip_from 197.234.240.0/22;
      set_real_ip_from 198.41.128.0/17;
      set_real_ip_from 162.158.0.0/15;
      set_real_ip_from 104.16.0.0/13;
      set_real_ip_from 104.24.0.0/14;
      set_real_ip_from 172.64.0.0/13;
      set_real_ip_from 131.0.72.0/22;

      # Cloudflare IPv6
      set_real_ip_from 2400:cb00::/32;
      set_real_ip_from 2606:4700::/32;
      set_real_ip_from 2803:f800::/32;
      set_real_ip_from 2405:b500::/32;
      set_real_ip_from 2405:8100::/32;
      set_real_ip_from 2a06:98c0::/29;
      set_real_ip_from 2c0f:f248::/32;
    '';

    # Main site
    virtualHosts."rishabhhaldiya.me" = {
      root = "/var/www/rishabhhaldiya.me";

      enableACME = true;
      forceSSL = true;

      extraConfig = ''
        # Allow ONLY Cloudflare
        allow 173.245.48.0/20;
        allow 103.21.244.0/22;
        allow 103.22.200.0/22;
        allow 103.31.4.0/22;
        allow 141.101.64.0/18;
        allow 108.162.192.0/18;
        allow 190.93.240.0/20;
        allow 188.114.96.0/20;
        allow 197.234.240.0/22;
        allow 198.41.128.0/17;
        allow 162.158.0.0/15;
        allow 104.16.0.0/13;
        allow 104.24.0.0/14;
        allow 172.64.0.0/13;
        allow 131.0.72.0/22;

        allow 2400:cb00::/32;
        allow 2606:4700::/32;
        allow 2803:f800::/32;
        allow 2405:b500::/32;
        allow 2405:8100::/32;
        allow 2a06:98c0::/29;
        allow 2c0f:f248::/32;

        deny all;
      '';
    };

    # www alias
    virtualHosts."www.rishabhhaldiya.me" = {
      root = "/var/www/rishabhhaldiya.me";

      enableACME = true;
      forceSSL = true;

      extraConfig = config.services.nginx.virtualHosts."rishabhhaldiya.me".extraConfig;
    };

    # Catch-all: reject IP / unknown hosts
    virtualHosts."_" = {
      default = true;
      rejectSSL = true;
    };
  };

  # ACME global config
  security.acme = {
    acceptTerms = true;
    defaults.email = "rishabhhaldiya.me@proton.me";
  };
}
