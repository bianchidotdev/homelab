{
  description = "bonkybot's test NixOS Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    deploy-rs.url = "github:serokell/deploy-rs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, deploy-rs, sops-nix }:
  let
    defaultSystem = { system ? "x86_64-linux", modules ? [], overlay ? true }@config: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = modules ++ [
        ./configuration.nix
        sops-nix.nixosModules.sops
      ];
    };
  in {
    nixosConfigurations = {
      bonkyserv = defaultSystem {
        modules = [
          ./bonkyserv/configuration.nix
          ./workloads/blocky.nix
          #./workloads/caddy.nix
          ./workloads/ddns.nix
          #./workloads/dontstarve.nix
          #./workloads/gluetun.nix
          ./workloads/jellyfin.nix
          ./workloads/monero.nix
          #./workloads/valheim.nix
          ./workloads/whoami.nix
        ];
      };
    };
    deploy = {
      sshOpts = [ "-t" ];
      remoteBuild = true;
      
      nodes = {
        bonkyserv = {
          hostname = "10.10.0.10";
          sshUser = "bonky";
          profiles = {
            system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations."bonkyserv";
            };
          };
        };
      };
    };
  };
}
