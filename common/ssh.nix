{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # settings = {
      passwordAuthentication = false;
      permitRootLogin = "no";
    #};
  };

  networking.firewall.allowedTCPPorts = [
    22
  ];
}
