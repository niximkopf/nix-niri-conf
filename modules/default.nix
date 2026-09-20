{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system/services.nix
    ./system/boot.nix
    ./system/nix.nix
    ./system/packages.nix
    ./system/kde.nix
    ./system/timezone.nix
    ./system/user.nix
    ./system/asus.nix
    ./system/fonts.nix
    ./config/sddm.nix
    ./config/nvim.nix
  ];

  system.stateVersion = "25.11";
}