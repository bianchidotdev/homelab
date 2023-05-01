{
  sops.secrets."blocky/config.yml" = {
    sopsFile = ../secrets/secrets.yaml;
    path = "/etc/blocky/config.yml";
  };

  virtualisation.oci-containers.containers = {
    blocky = {
      image = "spx01/blocky:latest";
      ports = [
        "4000:4000"
        "53:53/tcp"
        "53:53/udp"
      ];
      volumes = [
       "/etc/blocky/config.yml:/app/config.yml"
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      53
    ];
    allowedUDPPorts = [
      53
    ];
  };
}
