
{
  users.users.bonky = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ];
  };

  services.openssh.enable = true;

  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];
}
