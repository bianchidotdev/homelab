{
  services.consul = {
    enable = true;
    interface.bind = "enp6s0";
  };

  services.nomad = {
    enable = true;
    enableDocker = false;
    dropPrivileges = false;
    settings = {
      client = {
        enabled = true;
      };
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      datacenter = "bonk1";
      name = "bonkynomad";
    };
  };

  networking.firewall.allowedTCPPorts = [ 4646 ];
}
