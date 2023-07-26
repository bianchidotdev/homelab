{
  imports = [
    ./hardware-configuration.nix
  ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bonkygamer";
  networking.interfaces.enp4s0.useDHCP = true;
}
