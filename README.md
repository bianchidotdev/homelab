# Homelab

## Deploying

This repo uses [deploy-rs]() to deploy a standard config and specified workloads to machines running [NixOS]().

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

Adding new servers or admins requires updating `.sops.yaml` to ensure the correct public keys are used for the secrets encryption.

## TODO
* It'd be nice to set up a `nix run` or a `nix develop` command to facilitate the shell provisioning
* Some way to store workload config without relying on the user path
* Homemanager
