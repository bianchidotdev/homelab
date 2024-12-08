# Homelab

## Deploying
This homelab is deployed largely using GitHub Actions. Presently we are manually deploying docker-compose stacks to remote nodes. There is no clustered runtime and if a node goes down, those services go down.

### Vultr Tor Bridges

Vultr Tor Bridges are managed with terraform under `vultr/terraform/`.

The bridges are deployed with Flatcar Container Linux, which is a
container-optimized Linux distribution meant to be declaratively provisioned.

It uses an ignition config to provision the node, installing
tailscale and the systemd service to run a tor obfs4 bridge via docker.

We use a 1password service account to store the secrets needed for the
deployment.

Deploy with the following command:

```sh
cd vultr/terraform
op run --env-file=.env -- terraform apply
```
