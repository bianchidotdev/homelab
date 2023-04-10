{
  virtualisation.oci-containers.containers = {
    whoami = {
      image = "containous/whoami";
      ports = ["127.0.0.1:8080:80"];
    };
  };
}

