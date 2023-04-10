{
  security.acme = {
    acceptTerms = false;
    defaults.email = "michael@bianchi.dev";
  };
  services.mastodon = {
    enable = false;
    localDomain = "social.bonkybot.com";
    configureNginx = false;
    smtp.fromAddress = "noreply@social.bonkybot.com";
    extraConfig.SINGLE_USER_MODE = "true";
  };


  services.caddy = {
    enable = false;
  };
}
