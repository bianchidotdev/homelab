let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOxN58yRjg+8PNAcgCQzM26K9LLf8nH4J1PEqzXLGhQ5"
  ];
in
{
  users.users.bonky = {
    isNormalUser = true;
    # TODO(bianchi): secretize password
    # shell = pkgs.zsh;
    createHome = true;
    home = "/home/bonky";
    extraGroups = [ "wheel" "libvirtd" "podman" "docker" ];
    openssh.authorizedKeys.keys = keys;
  };

  security.sudo.wheelNeedsPassword = false;
}
