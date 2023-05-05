{ microvm, ... }:
{
  # virtualisation.libvirtd.enable = true;
  # The libvirtd module currently requires Polkit to be enabled ('security.polkit.enable = true').
  # security.polkit.enable = true;

  networking.useNetworkd = true;

  systemd.network = {
    enable = true;
    netdevs.virbr1.netdevConfig = {
      Kind = "bridge";
      Name = "virbr1";
    };
    networks.virbr1 = {
      matchConfig.Name = "virbr1";

      networkConfig = {
        DHCPServer = true;
        IPv6SendRA = true;
      };

      addresses = [
        {
          addressConfig.Address = "10.11.0.1/24";
        }
        {
          addressConfig.Address = "fd12:3456:789a::1/64";
        }
      ];
      ipv6Prefixes = [
        {
          ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
        }
      ];
    };
    networks.microvm-eth0 = {
      matchConfig.Name = "vm-*";
      networkConfig.Bridge = "virbr1";
    };
  };
  # Allow DHCP server
  networking.firewall.allowedUDPPorts = [ 67 ];
  # Allow Internet access
  networking.nat = {
    enable = true;
    enableIPv6 = true;
    internalInterfaces = [ "virbr1" ];
  };


  # systemd.network = {
  #   netdevs."10-microvm".netdevConfig = {
  #     Kind = "bridge";
  #     Name = "microvm";
  #   };
  #   networks."10-microvm" = {
  #     matchConfig.Name = "microvm";
  #     networkConfig = {
  #       DHCPServer = true;
  #       IPv6SendRA = true;
  #     };
  #     addresses = [ {
  #       addressConfig.Address = "10.11.0.1/24";
  #     } {
  #       addressConfig.Address = "fd12:3456:789a::1/64";
  #     } ];
  #     ipv6Prefixes = [ {
  #       ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
  #     } ];
  #   };
  # };

  # systemd.network = {
  #   networks."11-microvm" = {
  #     matchConfig.Name = "vm-*";
  #     networkConfig.Bridge = "microvm";
  #   };
  # };

  # microvm.vms = {
  #   my-microvm = {
  #     # Host build-time reference to where the MicroVM NixOS is defined
  #     # under nixosConfigurations
  #     flake = self;
  #     # Specify from where to let `microvm -u` update later on
  #     # updateFlake = "git+file:///etc/nixos";
  #   };
  # };

  # try to automatically start these MicroVMs on bootup
  microvm.autostart = [
    "my-microvm"
    # # "your-microvm"
    # "their-microvm"
  ];
}