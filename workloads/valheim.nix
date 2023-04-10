{
  virtualisation.oci-containers.containers = {
    valheim = {
      image = "ghcr.io/lloesche/valheim-server";
      ports = [
        "2456-2457:2456-2457/udp"
        "9001:9001/tcp"
      ];
      volumes = [
       "/home/bonky/workspace/valheim/config:/config"
       "/home/bonky/workspace/valheim/data:/opt/valheim"
      ];
      environmentFiles = [
        "/home/bonky/workspace/valheim/.env"
      ];
      extraOptions = [
        "--cap-add=sys_nice"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    9001
  ];
}
