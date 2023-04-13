{
  description = "bonkybot's test NixOS Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = { self, nixpkgs, deploy-rs }:
  let
    defaultSystem = { system ? "x86_64-linux", modules ? [], overlay ? true }@config: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = modules ++ [
        ./configuration.nix
      ];
    };
  in {
    nixosConfigurations = {
      bonkyserv = defaultSystem {
        modules = [
          ./workloads/blocky.nix
          ./workloads/ddns.nix
	  ./workloads/gluetun.nix
          ./workloads/jellyfin.nix
          ./workloads/monero.nix
          ./workloads/valheim.nix
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
