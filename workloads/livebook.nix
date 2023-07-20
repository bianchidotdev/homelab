{
  sops.secrets."livebook.env" = { };
  virtualisation.oci-containers.containers = {
    livebook = {
      image = "ghcr.io/livebook-dev/livebook";
      ports = [
        "8080:8080"
        "8081:8081"
      ];
      environmentFiles = [
        config.sops.secrets."livebook.env".path
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      8080
      8081
    ];
  };
}
