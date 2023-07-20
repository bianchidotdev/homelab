{
  sops.secrets."livebook.env" = { };
  virtualisation.oci-containers.containers = {
    livebook = {
      image = "ghcr.io/livebook-dev/livebook:latest-cuda11.8";
      ports = [
        "8082:8080"
        "8081:8081"
      ];
      volumes = [
        "/data/livebook:/data"
      ]
      environmentFiles = [
        config.sops.secrets."livebook.env".path
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      8082
      8081
    ];
  };
}
