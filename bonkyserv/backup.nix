{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.restic ];

  environment.etc."restic/restic-ignore" = {
    text = ''
      # exclude media files
      media/
      *.mp4
      *.mkv
      *.m4v
      *.avi
    '';
  };

  sops.secrets.cloudflare-r2-data-backup-creds = {
    sopsFile = ./secrets/secrets.yaml;
  };

  sops.secrets.restic-data-password = {
    sopsFile = ./secrets/secrets.yaml;
  };

  services.restic.backups.data-to-r2 = {
    initialize = true;
    repository = "s3:https://783680ac3df521a60e7687b14aa11486.r2.cloudflarestorage.com/bonkyserv-data";

    paths = [
      "/data"
    ];

    extraBackupArgs = [
      "--exclude-file=/etc/restic/restic-ignore"
    ];

    environmentFile = config.sops.secrets.cloudflare-r2-data-backup-creds.path;
    passwordFile = config.sops.secrets.restic-data-password.path;

    timerConfig = {
      # backup every 1d
      OnUnitActiveSec = "1d";
    };

    # keep 2 daily, 2 weekly, and 1 monthly backups
    pruneOpts = [
      "--keep-daily 2"
      "--keep-weekly 2"
      "--keep-monthly 1"
    ];
  };
}