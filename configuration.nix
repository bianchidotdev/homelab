# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./common/default.nix
      ./common/users.nix
      ./common/pkgs.nix
      ./common/ssh.nix
      ./common/tailscale.nix
      ./common/oci.nix
    ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.docker0.useDHCP = true;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.tailscale0.useDHCP = true;
  networking.interfaces.virbr0.useDHCP = true;

  # TODO(bianchi): secret-ize nextdns nameservers
  networking.nameservers = [ "45.90.28.14" "45.90.30.14" "9.9.9.9" ];

  i18n.defaultLocale = "en_US.UTF-8";

  # create /etc configuration files
  /*
  environment.etc = {
    "nomad.d/config.hcl".source = ./etc/nomad.d/config.hcl;
  };
  */

  # List services that you want to enable:
  services.dnsmasq.enable = false;

  # Open ports in the firewall.
  networking.firewall.checkReversePath = "loose";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # TODO(bianchi): figure out where how to generate and where to store config files for our workloads
}
