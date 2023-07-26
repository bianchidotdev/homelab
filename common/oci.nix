{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
  ];

  virtualisation = {
    oci-containers.backend = "docker";

    docker = {
      enable = true;
    };

    podman = {
      enable = false;
    };
  };
  
  networking.interfaces.docker0.useDHCP = true;
}
