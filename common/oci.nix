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
  
}
