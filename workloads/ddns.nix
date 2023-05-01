{ pkgs, config, ... }:
{
  sops.secrets."cloudflare-ddns.env" = { };
  virtualisation.oci-containers.containers = {
    ddns = {
      image = "oznu/cloudflare-ddns:latest";
      environmentFiles = [
        config.sops.secrets."cloudflare-ddns.env".path
      ];
    };
  };
}

