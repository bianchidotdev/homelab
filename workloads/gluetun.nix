{
  virtualisation.oci-containers.containers = {
    gluetun = {
      image = "qmcgaw/gluetun:v3";
      ports = [
        "8388:8388/tcp" # Shadowsocks
        "8388:8388/udp" # Shadowsocks
      ];
      extraOptions = [
        "--cap-add=NET_ADMIN"
      ];
      environmentFiles = [
        "/home/bonky/workspace/gluetun/.env"
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      8388
    ];
    allowedUDPPorts = [
      8388
    ];
  };
}
