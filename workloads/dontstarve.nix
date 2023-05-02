{
  virtualisation.oci-containers.containers = {
    dontstarve = {
      image = "jamesits/dst-server:latest";
      ports = [
        "10999:10999/udp"
        "11000:11000/udp"
        "12346:12346/udp"
        "12347:12347/udp"
      ];
      volumes = [
       "/data/dontstarve:/data"
      ];
    };
  };

  networking.firewall = {
    allowedUDPPorts = [
      10999
      11000
      12346
      12347
    ];
  };
}
