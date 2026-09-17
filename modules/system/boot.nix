{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
	      enable  = true;
	      device  = "nodev";
	      efiSupport = true;
        theme = ../../assets/grub-theme/Stardew-Valley;
      };
      efi.canTouchEfiVariables = true;
    };
    # Neuester stabiler Kernel (wegen rx9070xt)
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
