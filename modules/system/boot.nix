{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
	      enable  = true;
	      device  = "nodev";
	      efiSupport = true;
        theme = ../../assets/grub-theme/KayokoOnikataGRUB;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
