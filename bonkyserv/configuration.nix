{ config, nixpkgs, microvm, ...}:
{ 
  imports = [
    ./backup.nix
    ./virtualisation.nix
  ];
  
  networking.hostName = "bonkyserv";
}