{
  services.monero = {
    enable = true;
    extraConfig = "confirm-external-bind=1";
    rpc = {
      address = "0.0.0.0";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      18081
    ];
    allowedUDPPorts = [
      2456
      2457
    ];
  };
}
