{ pkgs, ... }:

{
  boot = {
    loader = {
      #systemd-boot = {
      #  enable = true;
      #  editor = false;
      #};
      systemd-boot.enable = false;
      grub = {
	      enable  = true;
	      device  = "nodev";
	      efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # Neuester stabiler Kernel (wegen rx9070xt)
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
