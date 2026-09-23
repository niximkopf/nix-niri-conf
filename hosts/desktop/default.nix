{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/services.nix
    ../../modules/system/boot.nix
    ../../modules/system/nix.nix
    ../../modules/system/packages.nix
    ../../modules/system/kde.nix
    ../../modules/system/timezone.nix
    ../../modules/system/user.nix
    ../../modules/system/asus.nix
    ../../modules/system/fonts.nix
    ../../modules/config/sddm.nix
    ../../modules/config/nvim.nix
  ];

  networking = {
    hostName = "nix-btw";
    networkmanager.enable = true;
    firewall = {
      enable          = true;
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
    };
  };

  services = {
    xserver = {
    	videoDrivers     = [ "amdgpu" ];
    };
  };

  system.stateVersion = "25.11";
}