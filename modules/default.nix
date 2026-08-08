{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system/services.nix
    ./system/boot.nix
    ./system/nix.nix
    ./system/packages.nix
    ./system/timezone.nix
    ./system/user.nix
    ./design/asus.nix
    ./design/fonts.nix
    ./design/sddm.nix
    #./design/momo.nix
  ];

  system.stateVersion = "25.11";
}