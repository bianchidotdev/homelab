{
  services.tailscale.enable = true;
  networking.interfaces.tailscale0.useDHCP = true;

  # warning: Strict reverse path filtering breaks Tailscale exit node use and some subnet routing setups. Consider setting:
  networking.firewall.checkReversePath = "loose";
  # TODO use token to bootstrap instead of requiring manual work
}