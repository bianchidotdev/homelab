# Homelab

## Deploying

This repo uses [deploy-rs](https://github.com/serokell/deploy-rs/) to deploy a standard config and specified workloads to machines running [NixOS](https://nixos.org/).

First install nix package manager locally and enable experimental features command and flakes.

Then, start up a `deploy-rs` shell and run deploy

``` sh
# one-time config
sh <(curl -L https://nixos.org/nix/install) --daemon
echo "experimental-features = nix-command flakes" | sudo tee /etc/nix/conf.nix

# actually deploy
nix shell github:serokell/deploy-rs
nix flake update
nix flake check
# for all servers
deploy

# for a single server
deploy ".#<server_name>"
```

## Setting secrets
Any server-independent secrets can be set in `./secrets/secrets.yaml`, while server-specific secrets live in `./<server-name>/secrets/secrets.yaml`.

Set secrets using `sops` so they are not stored in cleartext. NixOS will decrypt them at boot-time.

```sh
sops secrets/secrets.yaml
# make changes and save file
# commit changes
```

Reference the secrets as follows:

```nix
{
  # declare the secret
  sops.secrets.<secret-name> = {
    # optionally define source path
    # sopsFile = ./secrets/secrets.yaml
    # optionally define symlink path
    # path = /etc/example.yaml
  };

  some-nix.configPath = sops.secrets.<secret-name>.path;
}
```

Adding new servers or admins requires updating `.sops.yaml` to ensure the correct public keys are used for the secrets encryption (and re-opening all the sops files?).

## Backups

Data backups are done using [restic](https://restic.net/). Backups run daily.

To use restic commands manually, use the following:

```sh
# I know this is a pain, but :shrug:
sudo env $(sudo grep -v '^#' ${CLOUDFLARE_DATA_CREDS_FILE} | xargs -d '\n') restic <restic commands>

# list snapshots
sudo env $(sudo grep -v '^#' ${CLOUDFLARE_DATA_CREDS_FILE} | xargs -d '\n') restic list snapshots

# restore from snapshot
sudo env $(sudo grep -v '^#' ${CLOUDFLARE_DATA_CREDS_FILE} | xargs -d '\n') restic restore <snapshot_id> --target /path/to/dest
```

## Application Config

[nix-sops](https://github.com/Mic92/sops-nix) doesn't really allow for including secrets as part of a larger application config file.

This is a bit of a pain, but it seems to be for a good reason - secrets aren't known at "compile"-time, only at evaluation time (which makes sense given the deploying client doesn't need to see secrets to ship them).

As a result, any app config file that contains even a single secret, I'm storing the entire file in a sops secret.


For non-secret app config:

```nix
  environment.etc."<appname>/config.yml" = {
    text = ""
      # arbitrary yaml
      foo: bar
    ""
  }
```

> **Note**
> I should probably not be using /etc for this type of config and instead relying on creating temp files in the `/nix/store`, but I'm so used to seeing app config in `/etc` that I'm sticking with that for the moment. It's probably better to go the route of using .... It may also be better to store the files locally and reference them with the `source` tag instead of embedding them into the `.nix` file.

And config files that contain secrets:

```nix
# first setting the secret using `sops secrets/secrets.yaml`
{
  sops.secrets."<appname>/config.yml" = { };
  some-nix-service = {
    secretFile = config.sops.secrets."<appname>/config.yml".path;
  };
}
```

## TODO
* It'd be nice to set up a `nix run` or a `nix develop` command to facilitate the shell provisioning
* Homemanager
