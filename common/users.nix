{ config, ... }:
let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOxN58yRjg+8PNAcgCQzM26K9LLf8nH4J1PEqzXLGhQ5"
  ];
in
{
  sops.secrets.bonky-password = {
    neededForUsers = true;
  };

  users.users.bonky = {
    isNormalUser = true;
    passwordFile = config.sops.secrets.bonky-password.path;
    # shell = pkgs.zsh;
    createHome = true;
    home = "/home/bonky";
    extraGroups = [ "wheel" "libvirtd" "podman" "docker" ];
    openssh.authorizedKeys.keys = keys;
  };

  security.sudo.wheelNeedsPassword = false;
}
