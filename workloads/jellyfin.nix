{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "bonky";
    group = "users";
  };
}
