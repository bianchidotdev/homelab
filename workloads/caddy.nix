
{
  services.caddy = {
    enable = true;

    email = "michael@bianchi.dev";

    logFormat = ''
    level INFO
    '';

    virtualHosts."media.bonkybot.com".extraConfig = ''
      reverse_proxy http://127.0.0.1:8096
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [
      80 443
    ];
  };
}
