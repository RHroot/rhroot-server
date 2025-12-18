{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    enable = true;

    virtualHosts."rishabhhaldiya.me" = {
      root = "/var/www/rishabhhaldiya.me";
    };

    virtualHosts."www.rishabhhaldiya.me" = {
      root = "/var/www/rishabhhaldiya.me";
    };
  };
}
