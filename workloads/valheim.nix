{
  sops.secrets."valheim.env" = { };

  virtualisation.oci-containers.containers = {
    valheim = {
      image = "ghcr.io/lloesche/valheim-server";
      ports = [
        "2456-2457:2456-2457/udp"
        "9001:9001/tcp"
      ];
      volumes = [
       "/data/valheim/config:/config"
       "/data/valheim/data:/opt/valheim"
      ];
      environmentFiles = [
        config.sops.secrets."valheim.env".path
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
