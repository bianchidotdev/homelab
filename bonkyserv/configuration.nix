{
  imports = [
    ./hardware-configuration.nix
    ./backup.nix
  ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bonkyserv";
  networking.interfaces.enp6s0.useDHCP = true;
}