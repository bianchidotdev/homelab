
{
  services.openssh.enable = true;

  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
}
