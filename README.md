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
deploy
```

## TODO
* Still need to manage secrets
* It'd be nice to set up a `nix run` or a `nix develop` command to facilitate the shell provisioning
* Some way to store workload config without relying on the user path
* Homemanager


