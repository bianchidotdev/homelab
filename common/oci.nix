{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    docker
  ];

  virtualisation.docker.enable = true;
  virtualisation = {
    oci-containers.backend = "docker";
    
    podman = {
      enable = false;
    };
  };
  
  networking.interfaces.docker0.useDHCP = true;
}
