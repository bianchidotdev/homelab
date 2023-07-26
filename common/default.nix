
{
  services.openssh.enable = true;

  security.sudo.extraRules = [{
    users = [ "bonky" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  sops.defaultSopsFile = ../secrets/secrets.yaml;
}
